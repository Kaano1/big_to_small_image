# Subnets Public

resource "aws_subnet" "terraform_public_ip_1" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.10.0/24"
	map_public_ip_on_launch = true # Enable public IP

	tags = {
		Name = "terraform_public_ip_1" # Name of the subnet
	}

	availability_zone = "eu-north-1a"
	depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "terraform_public_ip_2" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.20.0/24"
	map_public_ip_on_launch = true # Enable public IP

	tags = {
		Name = "terraform_public_ip_2" # Name of the subnet
	}

	availability_zone = "eu-north-1b"
	depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "terraform_public_ip_3" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.30.0/24"
	map_public_ip_on_launch = true # Enable public IP

	tags = {
		Name = "terraform_public_ip_3" # Name of the subnet
	}

	availability_zone = "eu-north-1c"
	depends_on = [aws_vpc.terraform_vpc]
}


# Subnets Private

resource "aws_subnet" "terraform_private_ip_1" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.11.0/24"

	tags = {
		Name = "terraform_private_ip_1" # Name of the subnet
	}

	availability_zone = "eu-north-1a"
	depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "terraform_private_ip_2" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.21.0/24"

	tags = {
		Name = "terraform_private_ip_2" # Name of the subnet
	}
	
	availability_zone = "eu-north-1b"
	depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "terraform_private_ip_3" {
	vpc_id = aws_vpc.terraform_vpc.id
	cidr_block = "10.0.31.0/24"

	tags = {
		Name = "terraform_private_ip_3" # Name of the subnet
	}

	availability_zone = "eu-north-1c"
	depends_on = [aws_vpc.terraform_vpc]
}
