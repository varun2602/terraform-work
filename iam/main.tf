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
  users_data = yamldecode(file("./users.yml")).users
}
output "user_data" {
  value = local.users_data[*].username
}

resource "aws_iam_user" "iam_user" {
  for_each = toset(local.users_data[*].username)
  name = each.value
}

resource "aws_iam_user_login_profile" "example" {
  for_each = iam_user
  user    = each.value.name
  # pgp_key = "keybase:some_person_that_exists"
  password_length = 12

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      # pgp_key,
    ]
  }
}
# Create a VPC
# resource "aws_vpc" "example" {
#   cidr_block = "10.0.0.0/16"
# }