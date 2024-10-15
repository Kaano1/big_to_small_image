resource "aws_ami_from_instance" "terraform_instance_snapshot" {
  name               = "terraform_instance_snapshot"
  source_instance_id = aws_instance.terraform-ec2-instance.id
  snapshot_without_reboot = true

  tags = {
    Name = "terraform_instance_snapshot"
  }

  depends_on         = [null_resource.ansible-start]
}
