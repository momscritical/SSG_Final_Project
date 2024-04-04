variable "vpc_configs" {
  description = "List of VPC configurations"
  type        = list(object({
    cidr_block           = string
    name                 = string
  }))
}