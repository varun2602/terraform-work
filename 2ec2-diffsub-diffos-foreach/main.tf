terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  count = 2
  vpc_id = aws_vpc.my-vpc.id 
  cidr_block = "10.0.${count.index}.0/24"
}

resource "aws_instance" "my-ec2" {
   for_each = var.ec2_config 
   subnet_id = element(aws_subnet.main[*].id, index(keys(var.ec2_config), each.key)%length(aws_subnet.main))
   ami = each.value.ami 
   instance_type = each.value.instance_type
}