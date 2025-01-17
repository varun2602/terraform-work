variable "vpc_config" {
  type = object({
    name = string 
    cidr_block = string
  })
  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR block format: ${var.vpc_config.cidr_block}. Please provide a valid CIDR block."
  
  }
}

variable "subnet_config" {
  type = map(object({
    cidr_block = string 
    az = string
  }))
  validation {
    condition = alltrue([for key, config in var.subnet_config: can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid config format"
  }
}
