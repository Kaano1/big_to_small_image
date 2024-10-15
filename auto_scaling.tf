resource "aws_launch_template" "terraform_launch_template" {
  name          = "terraform_launch_template"
  image_id     = aws_ami_from_instance.terraform_instance_snapshot.id
  instance_type = "t3.micro"
  key_name      = "myComputer"
  
  vpc_security_group_ids = [aws_security_group.security_group.id]
  depends_on   = [aws_ami_from_instance.terraform_instance_snapshot]
}

resource "aws_autoscaling_group" "terraform_auto_scaling" {
  launch_template {
    id      = aws_launch_template.terraform_launch_template.id
    version = "$Latest" 
  }

  min_size            = 3
  max_size            = 5
  desired_capacity     = 3
  vpc_zone_identifier = [aws_subnet.terraform_public_ip_1.id, aws_subnet.terraform_public_ip_2.id, aws_subnet.terraform_public_ip_3.id]
  target_group_arns   = [aws_lb_target_group.target_group.arn]
  health_check_type   = "ELB"
  health_check_grace_period = 200

  depends_on = [aws_launch_template.terraform_launch_template]
}

resource "aws_cloudwatch_metric_alarm" "terraform_cloudwatch_metric_alarm_high" {
  alarm_name          = "terraform_cloudwatch_metric_alarm_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = "60"
  statistic          = "Average"
  threshold          = "70"
  alarm_actions      = [aws_autoscaling_policy.auto_scaling_policy_high_cpu.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.terraform_auto_scaling.name
  }

  depends_on = [aws_autoscaling_policy.auto_scaling_policy_high_cpu]
}

resource "aws_autoscaling_policy" "auto_scaling_policy_high_cpu" {
  name                    = "auto_scaling_policy_high_cpu"
  adjustment_type         = "ChangeInCapacity"
  autoscaling_group_name  = aws_autoscaling_group.terraform_auto_scaling.name
  policy_type             = "SimpleScaling"
  scaling_adjustment       = "1"
  cooldown                = "300"

  depends_on = [aws_autoscaling_group.terraform_auto_scaling]
}

resource "aws_cloudwatch_metric_alarm" "terraform_cloudwatch_metric_alarm_low" {
  alarm_name          = "terraform_cloudwatch_metric_alarm_low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = "60"
  statistic          = "Average"
  threshold          = "30"
  alarm_actions      = [aws_autoscaling_policy.auto_scaling_policy_low_cpu.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.terraform_auto_scaling.name
  }

  depends_on = [aws_autoscaling_policy.auto_scaling_policy_low_cpu]
}

resource "aws_autoscaling_policy" "auto_scaling_policy_low_cpu" {
  name                    = "auto_scaling_policy_low_cpu"
  adjustment_type         = "ChangeInCapacity"
  autoscaling_group_name  = aws_autoscaling_group.terraform_auto_scaling.name
  policy_type             = "SimpleScaling"
  scaling_adjustment       = "-1"
  cooldown                = "300"

  depends_on = [aws_autoscaling_group.terraform_auto_scaling]
}
