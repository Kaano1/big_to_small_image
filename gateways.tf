# Internet Gateway

resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.terraform_vpc.id

	tags = {
		Name = "terraform_igw" # Name of the Internet Gateway
	}
	
	depends_on = [aws_vpc.terraform_vpc]
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
