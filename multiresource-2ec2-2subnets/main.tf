terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
locals {
  project = "project-01"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  profile = "default"
}

# Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}
# Creating 4 Ec2 instances 
resource "aws_instance" "main" {
  ami = "ami-01816d07b1128cd2d"
  instance_type = "t3.micro"
  count = 4 
  subnet_id = element(aws_subnet.main[*].id, count.index%length(aws_subnet.main))
  tags = {
    Name = "${local.project}-ec2-${count.index}"
  }
}

output "aws_subnet_id" {
  value = [for subnet in aws_aws_subnet.main:subnet.id]
}

