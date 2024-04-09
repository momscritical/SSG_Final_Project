variable "vpc_name" {
  type = string
  default = ""
}

variable "vpc_cidr" {
  type = string
  default = ""
}

variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames for the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Whether to enable DNS support for the VPC"
  type        = bool
  default     = true
}