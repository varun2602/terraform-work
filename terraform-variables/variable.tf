variable "region"{
    description = "Value of region"
    type = string 
    # default = "us-east-1"
    validation {
      condition = var.region == "us-east-1" ||  var.region == "us-west-1"
      error_message = "Only us-east-1 or us-west-1 allowed"
    }
}

variable "ec2-config" {
  type = object({
    volume_size = number 
    volume_type = string  
  })

  default = {
    volume_size = 30 
    volume_type = "gp2"
  }
}