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

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
}


resource "aws_instance" "myec2server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2-config.volume_size
    volume_type = var.ec2-config.volume_type
  }

  tags = {
    Name = "myec2"
  }
}