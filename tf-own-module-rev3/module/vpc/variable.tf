variable "vpc_config" {
  type = object({
    name = string 
    cidr_block = string 
  })
  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid cidr block - ${var.vpc_config.cidr_block}"
  }
}

variable "subnet_config" {
  type = map(object({
    cidr_block = string 
    az = string
    public = optional(bool, false)
  }))
  validation {
    condition = alltrue([for key, config in var.subnet_config: can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid cidr block"
  }
}