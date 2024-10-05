provider "aws" {
	region = "eu-north-1" # Stockholm
}


resource "aws_vpc" "terraform_vpc" {
	cidr_block = "10.0.0.0/16" # 65,536 IP addresses if you want to different size you can change it
	instance_tenancy = "default" # default or dedicated

	tags = {
		Name = "terraform_vpc" # Name of the VPC
	}
}

# Internet Gateway

resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.terraform_vpc.id

	tags = {
		Name = "terraform_igw" # Name of the Internet Gateway
	}
	
	depends_on = [aws_vpc.terraform_vpc]
}

# Nat Gateway




# Subnets Public

resource "aws_subnet" "terraform_public_ip_1" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.10.0/24"
	map_public_ip_on_launch = true # Enable public IP

	tags = {
		Name = "terraform_public_ip_1" # Name of the subnet
	}

	depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "terraform_public_ip_2" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.20.0/24"
	map_public_ip_on_launch = true # Enable public IP

	tags = {
		Name = "terraform_public_ip_2" # Name of the subnet
	}

	depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "terraform_public_ip_3" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.30.0/24"
	map_public_ip_on_launch = true # Enable public IP

	tags = {
		Name = "terraform_public_ip_3" # Name of the subnet
	}

	depends_on = [aws_vpc.terraform_vpc]
}


# Subnets Private

resource "aws_subnet" "terraform_private_ip_1" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.11.0/24"

	tags = {
		Name = "terraform_private_ip_1" # Name of the subnet
	}

	depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "terraform_private_ip_2" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.21.0/24"

	tags = {
		Name = "terraform_private_ip_2" # Name of the subnet
	}

	depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "terraform_private_ip_3" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.31.0/24"

	tags = {
		Name = "terraform_private_ip_3" # Name of the subnet
	}

	depends_on = [aws_vpc.terraform_vpc]
}

# Public Route Tables (Default Route)

resource "aws_default_route_table" "terraform_route_table_public" {
	default_route_table_id = aws_vpc.terraform_vpc.default_route_table_id

	route {
		cidr_block = "10.0.0.0/16"
		gateway_id = "local"
	}

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.igw.id
	}

	tags = {
		Name = "public_vpc_route_table"
	}
}

# Private Route Table
resource "aws_route_table" "terraform_route_table_private" {
	vpc_id = aws_vpc.terraform_vpc.id

	route {
		cidr_block = "10.0.0.0/16"
		gateway_id = "local"
	}

	route {
		cidr_block = "0.0.0.0/0"
		nat_gateway_id = aws_nat_gateway.nat_gateway-1.id
	}

	tags = {
		Name = "private_vpc_route_table"
	}
	depends_on = [aws_vpc.terraform_vpc]
}

# Subnets Public Route Table Association

resource "aws_route_table_association" "route_table_association_public" {
	for_each = {
		subnet1 = aws_subnet.terraform_public_ip_1.id
		subnet2 = aws_subnet.terraform_public_ip_2.id
		subnet3 = aws_subnet.terraform_public_ip_3.id
	}

	subnet_id = each.value
	route_table_id = aws_default_route_table.terraform_route_table_public.id

	depends_on = [aws_default_route_table.terraform_route_table_public]
}


# Subnets Private Route Table Association

resource "aws_route_table_association" "route_table_association_private" {
	for_each = {
		subnet1 = aws_subnet.terraform_private_ip_1.id
		subnet2 = aws_subnet.terraform_private_ip_2.id
		subnet3 = aws_subnet.terraform_private_ip_3.id
	}

	subnet_id = each.value
	route_table_id = aws_route_table.terraform_route_table_private.id

	depends_on = [aws_route_table.terraform_route_table_private]
}

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


# Elastic IP

resource "aws_eip" "elastic_ip" {
	vpc = true

	tags = {
		Name = "terraform_elastic_ip"
	}
# Nat Gateway

resource "aws_nat_gateway" "nat_gateway-1" {
	allocation_id = aws_eip.elastic_ip.id
	subnet_id = aws_subnet.terraform_public_ip_1.id

	tags = {
		Name = "terraform_nat_gateway-1"
	}

	depends_on = [aws_eip.elastic_ip, aws_subnet.terraform_public_ip_1]
}
