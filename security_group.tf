
# Security Group

resource "aws_security_group" "security_group" {
	vpc_id = aws_vpc.terraform_vpc.id
	name = "terraform_security_group"
	description = "Allow inbound and outbound traffic"

	tags = {
		Name = "terraform_security_group"
	}
}

# Security Group Egress Rules

resource "aws_security_group_rule" "set_egress-1" {
  type              = "egress"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  security_group_id = aws_security_group.security_group.id
  cidr_blocks      = ["0.0.0.0/0"]
}


# Security Group Ingress Rules
resource "aws_vpc_security_group_ingress_rule" "set_ingress-1" {
	security_group_id = aws_security_group.security_group.id
	cidr_ipv4 = aws_vpc.terraform_vpc.cidr_block
	from_port = 443
	to_port = 443
	ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "set_ingress-2" {
	security_group_id = aws_security_group.security_group.id
	cidr_ipv4 = aws_vpc.terraform_vpc.cidr_block
	from_port = 80
	to_port = 80
	ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "set_ingress-3" {
	security_group_id = aws_security_group.security_group.id
	cidr_ipv4 = aws_vpc.terraform_vpc.cidr_block
	from_port = 22
	to_port = 22
	ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "set_ingress-4" {
	security_group_id = aws_security_group.security_group.id
	cidr_ipv4 = aws_vpc.terraform_vpc.cidr_block
	ip_protocol = "icmp"
	from_port = -1
	to_port = -1
}
