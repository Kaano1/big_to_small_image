resource "aws_db_instance" "rds_instance" {
	allocated_storage = 20
	db_name = "proje"
	engine = "mysql"
	engine_version = "8.0"
	instance_class = "db.t3.micro"
	username = "projemaster"
	password = "master1234"
	identifier = "projedbinstance"
	skip_final_snapshot   = true
	vpc_security_group_ids = [aws_security_group.rds_security_group.id]
	db_subnet_group_name = aws_db_subnet_group.default_vpc.name
} # vpc oluştur vpc ile bağlantıyı sec group üzerinden yap ec2 ya gir

resource "aws_db_subnet_group" "default_vpc" {
  name       = "main"
  subnet_ids = [aws_subnet.terraform_public_ip_1.id, aws_subnet.terraform_public_ip_2.id, aws_subnet.terraform_public_ip_3.id]

  tags = {
    Name = "RDS-Terraform DB subnet group"
  }
}
