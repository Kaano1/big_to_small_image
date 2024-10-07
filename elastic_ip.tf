# Elastic IP

resource "aws_eip" "elastic_ip" {
	domain = "vpc"

	tags = {
		Name = "terraform_elastic_ip"
	}

	depends_on = [aws_vpc.terraform_vpc]
}
