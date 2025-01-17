provider "aws" {
  region = "us-east-1"
}
module "vpc" {
  source = "./module/vpc"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name = "my-test-vpc"
  }
  subnet_config = {
    public_subnet = {
        cidr_block = "10.0.0.0/24"
        az = "us-east-1a"
    }
    private_subnet = {
        cidr_block = "10.0.1.0/24"
        az = "us-east-1b"
    }
  }
}