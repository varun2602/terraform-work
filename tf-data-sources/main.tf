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
data "aws_ami" "name" {
  most_recent = true
  owners = ["amazon"]

   filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
output "aws_ami" {
  value = data.aws_ami.name.id
}
# 3:12:00
# resource "aws_instance" "myec2server" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "myec2"
#   }
# }