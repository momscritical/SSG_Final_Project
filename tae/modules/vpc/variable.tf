################################### VPC ###################################
variable "vpc_cidr" {
  description = "VPC CIDR Values"
  type = string
  default = ""
}

variable "vpc_name" {
  description = "VPC Name Values"
  type = string
  default = ""
}

variable "enable_dns_hostnames" {
  description = "Whether to Enable DNS HostNames for the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Whether to Enable DNS Support for the VPC"
  type        = bool
  default     = true
}
################################## Availability Zones ##################################
variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = []
}

############################## Bastion Subnet ##############################
variable "public_subnet_cidr" {
  description = "Subnet CIDR Values for Public"
  type        = list(string)
  default     = []
}

variable "public_subnet_name" {
  description = "Subnet Name Values for Public"
  type = string
  default = ""
}

############################## Control Plane Subnet ##############################
variable "cp_subnet_cidr" {
  description = "Subnet CIDR Values for Control Plane Instance"
  type        = list(string)
  default     = []
}

variable "cp_subnet_name" {
  description = "Subnet Name Values for Control Plane Instance"
  type = string
  default = ""
}

############################## Application Subnet ##############################
variable "app_subnet_cidr" {
  description = "Subnet CIDR Values for EKS Application Node Group"
  type        = list(string)
  default     = []
}

variable "app_subnet_name" {
  description = "Subnet Name Values for EKS Application Node Group"
  type = string
  default = ""
}

############################## Set Subnet ##############################
variable "set_subnet_cidr" {
  description = "Subnet CIDR Values for EKS Setting Node Group"
  type        = list(string)
  default     = []
}

variable "set_subnet_name" {
  description = "Subnet Name Values for EKS Setting Node Group"
  type = string
  default = ""
}

############################## DataBase Subnet ##############################
variable "db_subnet_cidr" {
  description = "Subnet CIDR Values for Database"
  type        = list(string)
  default     = []
}

variable "db_subnet_name" {
  description = "Subnet Name Values for Database"
  type = string
  default = ""
}

################################# Gate Way #################################
variable "igw_name" {
  description = "Internet GateWay Name Value"
  type        = string
  default = ""
}

variable "ngw_name" {
  description = "NAT GateWay Name Value"
  type        = string
  default = ""
}

################################ Route Table ################################
variable "public_rt_name" {
  description = "Public Routing Table Name Value"
  type = string
  default = ""
}

variable "private_rt_name" {
  description = "Private Routing Table Name Value"
  type = string
  default = ""
}