provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zone" "name" {
  state = "available"
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"

  name = "my-vpc" 
  cidr = "10.0.0.0/16"

  azs = data.aws_availability_zone.name.names
  public_subnets = ["10.0.0.0/24"] 
  private_subnets = ["10.0.1.0/24"]
  enable_nat_gateway = true 
  enable_vpn_gateway = true 

  tags = {
    Name = "my-vpc"
  }
}
