# Region: eu-north-1
provider "aws" {
	region = "eu-north-1" # Stockholm
}

# VPC main_route_table_id

resource "aws_vpc" "terraform_vpc" {
	cidr_block = "10.0.0.0/16" # 65,536 IP addresses if you want to different size you can change it
	instance_tenancy = "default" # default or dedicated
	enable_dns_hostnames = true

	tags = {
		Name = "terraform_vpc" # Name of the VPC
	}
}