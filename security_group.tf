
# Security Group

resource "aws_security_group" "rds_security_group" {
	vpc_id = aws_vpc.terraform_vpc.id
	name = "rds_security_group"
	description = "Allow inbound and outbound traffic"

	tags = {
		Name = "rds_security_group"
	}
}

resource "aws_security_group" "security_group" {
	vpc_id = aws_vpc.terraform_vpc.id
	name = "terraform_security_group"
	description = "Allow inbound and outbound traffic"

	tags = {
		Name = "terraform_security_group"
	}
}

# rds_security_group Egress Rules

resource "aws_security_group_rule" "rds_set_egress-1" {
	type 			= "egress"
	from_port		= 3306
	to_port			= 3306
	protocol		= "tcp"
	security_group_id = aws_security_group.rds_security_group.id
	source_security_group_id = aws_security_group.security_group.id
}

# rds_security_group Ingress Rules


resource "aws_security_group_rule" "rds_set_ingress-1" {
	type 			= "ingress"
	from_port		= 3306
	to_port			= 3306
	protocol		= "tcp"
	security_group_id = aws_security_group.rds_security_group.id
	source_security_group_id = aws_security_group.security_group.id
}

# security_group Egress Rules

resource "aws_security_group_rule" "set_egress-1" {
  type              = "egress"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  security_group_id = aws_security_group.security_group.id
  cidr_blocks      = ["0.0.0.0/0"]
}

# security_group Ingress Rules
resource "aws_vpc_security_group_ingress_rule" "set_ingress-1" {
	security_group_id = aws_security_group.security_group.id
	cidr_ipv4 = "0.0.0.0/0"
	from_port = 443
	to_port = 443
	ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "set_ingress-2" {
	security_group_id = aws_security_group.security_group.id
	cidr_ipv4 = "0.0.0.0/0"
	from_port = 80
	to_port = 80
	ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "set_ingress-3" {
	security_group_id = aws_security_group.security_group.id
	cidr_ipv4 = "0.0.0.0/0"
	from_port = 22
	to_port = 22
	ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "set_ingress-4" {
	security_group_id = aws_security_group.security_group.id
	cidr_ipv4 = "0.0.0.0/0"
	ip_protocol = "icmp"
	from_port = -1
	to_port = -1
}

resource "aws_vpc_security_group_ingress_rule" "set_ingress-5" {
	security_group_id = aws_security_group.security_group.id
	cidr_ipv4 = "0.0.0.0/0"
	ip_protocol = "tcp"
	from_port = 2049
	to_port = 2049
}

resource "aws_security_group_rule" "allow_security_group" {
  type                     = "ingress"
  from_port                = 3306       
  to_port                  = 3306        
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.rds_security_group.id
  security_group_id        = aws_security_group.security_group.id
}

