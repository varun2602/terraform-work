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
  projectName = "project-diff-ec2"
}
# Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.projectName}-vpc"
  }

}

resource "aws_subnet" "main_subnet" {
  vpc_id =  aws_vpc.my-vpc.id 
  cidr_block = "10.0.${count.index}.0/24"
  count = 2 
  tags = {
    Name = "${local.projectName}-subnet-${count.index}"
  }
}

resource "aws_instance" "ec2_instance" {
  count = length(var.ec2_config)
  subnet_id = element(aws_subnet.main_subnet[*].id, count.index%length(aws_subnet.main_subnet))
  ami = var.ec2_config[count.index].ami
  instance_type = var.ec2_config[count.index].instance_type
}