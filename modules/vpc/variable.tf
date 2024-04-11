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

variable "public_subnet_name" {
    description = "Public Subnets name values"
  type = string
  default = ""
}

variable "web_subnet_name" {
  description = "Web Subnets name values"
  type = string
  default = ""
}

variable "was_subnet_name" {
  description = "WAS Subnets name values"
  type = string
  default = ""
}

variable "db_subnet_name" {
  description = "Database Subnets name values"
  type = string
  default = ""
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR values"
  type        = list(string)
  default     = []
}

variable "web_subnet_cidr" {
  description = "Web Subnet CIDR values"
  type        = list(string)
  default     = []
}

variable "was_subnet_cidr" {
  description = "WAS Subnet CIDR values"
  type        = list(string)
  default     = []
}

variable "db_subnet_cidr" {
  description = "Database Subnet CIDR values"
  type        = list(string)
  default     = []
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = []
}

variable "igw_name" {
  description = "Internet GateWay name Value"
  type        = string
  default = ""
}

variable "ngw_name" {
  description = "NAT GateWay name Value"
  type        = string
  default = ""
}

variable "public_rt_name" {
  description = "Public RoutingTable name values"
  type = string
  default = ""
}

variable "private_rt_name" {
  description = "Private RoutingTable name values"
  type = string
  default = ""
}