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
locals {
  project = "project-01"
}

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

output "aws_subnet_id" {
#   value = [for sub in aws_subnet.main: sub.id]
    value = aws_subnet.main[0].id
}