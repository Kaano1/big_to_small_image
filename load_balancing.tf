resource "aws_lb" "terraform_load_balancer" {
	name = "terraform-load-balancer"
	load_balancer_type = "application"
	internal = false
	subnets = [aws_subnet.terraform_public_ip_1.id, aws_subnet.terraform_public_ip_2.id, aws_subnet.terraform_public_ip_3.id]
	security_groups = [aws_security_group.security_group.id]
}

resource "aws_lb_target_group" "target_group" {
  name     = "target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform_vpc.id
}

resource "aws_lb_listener" "listener" {
	load_balancer_arn = aws_lb.terraform_load_balancer.arn
	port = "80"
	protocol = "HTTP"

	default_action {
		type = "forward"
		target_group_arn = aws_lb_target_group.target_group.arn
	}
}

resource "aws_lb_listener_rule" "listener_rule" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 100

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  condition {
    path_pattern {
      values = ["/index.html"]
    }
  }
}
