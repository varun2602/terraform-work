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

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-bucketaefjhbfb6"
}
resource "aws_s3_object" "myobjs" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  source = "D:\\cs50\\Cloud Solutions Architecture\\Terraform\\projects\\s3\\myfile.txt"
  key = "mydata.txt"
}
# 1:18