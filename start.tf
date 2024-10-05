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
