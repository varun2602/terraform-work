
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
  region = var.region
}

# Security group data source 
data "aws_security_group" "my-source-sg" {
  tags = {
    Name = "my-security-group"
  }
}

# vpc 
data "aws_vpc" "my-source-vpc" {
   tags = {
    Name = "my-vpc"
  }
}

data "aws_subnet" "my-source-subnet" {
   filter {
    name = "vpc-id"
    values = [data.aws_vpc.my-source-vpc.id]
   }
   filter {
    name = "tag:Name"
    values = ["private-subnet"]
   }
}

resource "aws_instance" "my-second-ec2" {
  ami = "ami-01816d07b1128cd2d"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.my-source-subnet.id
  security_groups = [data.aws_security_group.my-source-sg.id]
  tags = {
    Name = "second-ec2"
  }

}
