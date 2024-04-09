variable "vpc_id" {
  description = "ID of the VPC to associate subnets with"
  type        = string
  default = ""
}

variable "public_subnet_name" {
    description = "Public Subnets name values"
  type = string
  default = ""
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR values"
  type        = list(string)
  default     = []
}

variable "web_subnet_name" {
  description = "Web Subnets name values"
  type = string
  default = ""
}

variable "web_subnet_cidr" {
  description = "Web Subnet CIDR values"
  type        = list(string)
  default     = []
}


variable "was_subnet_name" {
  description = "WAS Subnets name values"
  type = string
  default = ""
}

variable "was_subnet_cidr" {
  description = "WAS Subnet CIDR values"
  type        = list(string)
   default     = []
}

variable "db_subnet_name" {
  description = "Database Subnets name values"
  type = string
  default = ""
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