terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
  region = var.region

}

# VPC 
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

# Private Subnet 
resource "aws_subnet" "myprivatesubnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "private-subnet"
  }
}

# public subnet 
resource "aws_subnet" "mypublicsubnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "public-subnet"
  }
}

# Internet gateway 
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.myvpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
}

resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.my_route_table.id
  subnet_id = aws_subnet.mypublicsubnet.id
}


# EC2
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

#   filters = {
#     name = "ubuntu/images/*/x86_64/generic-amd64*"
#   }
}


# Create a VPC
resource "aws_instance" "myec2server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.mypublicsubnet.id
  tags = {
    Name = "myec2"
  }
}
