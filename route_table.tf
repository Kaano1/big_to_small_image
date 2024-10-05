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
