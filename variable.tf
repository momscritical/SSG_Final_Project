variable "region" { 
  description = "AWS region" 
  type        = string 
  default     = "ap-northeast-1" 
}

variable "vpc_name" {
  type = string
  default = "Final-VPC"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
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
  default = "Bastion-Subnet"
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR values"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "web_subnet_name" {
  description = "Web Subnets name values"
  type = string
  default = "Web-Subnet"
}

variable "web_subnet_cidr" {
  description = "Web Subnet CIDR values"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "was_subnet_name" {
  description = "WAS Subnets name values"
  type = string
  default = "WAS-Subnet"
}

variable "was_subnet_cidr" {
  description = "WAS Subnet CIDR values"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "db_subnet_name" {
  description = "Database Subnets name values"
  type = string
  default = "Database-Subnet"
}

variable "db_subnet_cidr" {
  description = "Database Subnet CIDR values"
  type        = list(string)
  default     = ["10.0.201.0/24", "10.0.202.0/24"]
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1c"]
}