resource "aws_instance" "terraform-ec2-instance" {
	ami = "ami-097c5c21a18dc59ea" # Amazon Linux 2 AMI
	instance_type = "t3.micro" # Free tier eligible
	vpc_security_group_ids  = [aws_security_group.security_group.id]
	subnet_id = aws_subnet.terraform_public_ip_1.id
	iam_instance_profile = aws_iam_instance_profile.instance_profile.name
	key_name = "myComputer"

	tags = {
		Name = "terraform-ec2-instance"
	}

	depends_on = [aws_security_group.security_group, aws_subnet.terraform_public_ip_1, aws_iam_instance_profile.instance_profile, aws_efs_file_system.efs, aws_db_instance.rds_instance]
}

resource "aws_iam_instance_profile" "instance_profile" {
	name = "instance-profile"
	role = aws_iam_role.Ec2-S33.name

	depends_on = [aws_iam_role.Ec2-S33]
}

