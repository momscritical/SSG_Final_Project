#################################### VPC ####################################
variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR values"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "web_subnet_cidr" {
  description = "Web Subnet CIDR values"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "was_subnet_cidr" {
  description = "WAS Subnet CIDR values"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
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

variable "vpc_name" {
  type    = string
  default = "Final-VPC"
}

variable "public_subnet_name" {
  description = "Public Subnets name values"
  type        = string
  default     = "Bastion-Subnet"
}

variable "web_subnet_name" {
  description = "Web Subnets name values"
  type        = string
  default     = "Web-Subnet"
}

variable "was_subnet_name" {
  description = "WAS Subnets name values"
  type        = string
  default     = "WAS-Subnet"
}

variable "db_subnet_name" {
  description = "DataBase Subnets name values"
  type        = string
  default     = "DB-Subnet"
}

variable "igw_name" {
  description = "Internet Gateway name values"
  type        = string
  default     = "Internet-Gateway"
}

variable "ngw_name" {
  description = "NAT Gateway name values"
  type        = string
  default     = "NAT-Gateway"
}

variable "public_rt_name" {
  description = "Public Routing Table name values"
  type        = string
  default     = "Public-Routing-Table"
}

variable "private_rt_name" {
  description = "Private Routing Table name values"
  type        = string
  default     = "Private-Routing-Table"
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

#################################### Security Group ####################################
variable "bastion_sg_name" {
  description = "The Name of the Security Group for Bastion Instance"
  type = string
  default = "Public-SG"
}

variable "web_sg_name" {
  description = "The Name of the Security Group for Web Instance"
  type = string
  default = "Web-SG"
}

variable "was_sg_name" {
  description = "The Name of the Security Group for WAS Instance"
  type = string
  default = "WAS-SG"
}

variable "db_sg_name" {
  description = "The Name of the Security Group for DataBase"
  type = string
  default = "DataBase-SG"
}

variable "elb_sg_name" {
  description = "The Name of the Security Group External Load Balancer"
  type = string
  default = "Ext-LB-SG"
}

variable "ilb_sg_name" {
  description = "The Name of the Security Group Internal Load Balancer"
  type = string
  default = "Int-LB-SG"
}

variable "web_efs_sg_name" {
  description = "The Name of the Security Group for Web EFS"
  type = string
  default = "Web-EFS-SG"
}

variable "was_efs_sg_name" {
  description = "The Name of the Security Group for WAS EFS"
  type = string
  default = "WAS-EFS-SG"
}

variable "bastion_ing_ports" {
  description = "List of Ingress Ports for Bastion"
  type        = list(number)
  default     = ["22","9090","3000"]
}

variable "web_ing_ports" {
  description = "List of Ingress Ports for Web"
  type        = list(number)
  default     = ["22","9100","5000"]
}

variable "was_ing_ports" {
  description = "List of Ingress Ports for WAS"
  type        = list(number)
  default     = ["22","9100","5000"]
}

variable "db_ing_ports" {
  description = "List of Ingress Ports for DataBase"
  type        = list(number)
  default     = ["3306"]
}

variable "elb_ing_ports" {
  description = "List of Ingress Ports for External Loadbalancer"
  type        = list(number)
  default     = ["80"]
}

variable "ilb_ing_ports" {
  description = "List of Ingress Ports for Internal Loadbalancer"
  type        = list(number)
  default     = ["80","5000"]
}

variable "web_efs_ing_ports" {
  description = "List of Ingress Ports for Web EFS"
  type        = list(number)
  default     = ["2049"]
}

variable "was_efs_ing_ports" {
  description = "List of Ingress Ports for WAS EFS"
  type        = list(number)
  default     = ["2049"]
}