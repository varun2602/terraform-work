variable "ec2_config" {
  type = map(object({
    ami = string 
    instance_type = string
  }))
}