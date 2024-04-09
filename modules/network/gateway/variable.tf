variable "vpc_id" {
  description = "ID of the VPC to associate Routintable with"
  type        = string
  default = ""
}

variable "igw_name" {
  description = "Internet GateWay name Value"
  type        = string
  default = ""
}

variable "nat_eip_id" {
  description = "ID of the Elastic IP Address"
  type        = string
  default = ""
}

variable "subnet_id" {
  description = "ID of the Subnet to associate Routintable with"
  type        = string
  default = ""
}

variable "ngw_name" {
  description = "NAT GateWay name Value"
  type        = string
  default = ""
}