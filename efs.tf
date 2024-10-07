resource "aws_efs_file_system" "efs" {
  creation_token = "terraform-efs-ecole"

  tags = {
	Name = "terraform-efs-ecole"
  }
}

# mount subnets to the efs

resource "aws_efs_mount_target" "efs_mount-1" {
	file_system_id = aws_efs_file_system.efs.id
	subnet_id = aws_subnet.terraform_public_ip_1.id
	security_groups = [aws_security_group.security_group.id]
}

resource "aws_efs_mount_target" "efs_mount-2" {
	file_system_id = aws_efs_file_system.efs.id
	subnet_id = aws_subnet.terraform_public_ip_2.id
	security_groups = [aws_security_group.security_group.id]
}

resource "aws_efs_mount_target" "efs_mount-3" {
	file_system_id = aws_efs_file_system.efs.id
	subnet_id = aws_subnet.terraform_public_ip_3.id
	security_groups = [aws_security_group.security_group.id]
}

