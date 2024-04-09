variable "vpc_id" {
  description = "ID of the VPC to associate subnets with"
  type        = string
  default = ""
}

variable "rt_cidr" {
  description = "RoutingTable CIDR values"
  type = string
  default = ""
}

variable "igw_id" {
  description = "ID of the Internet GateWay to associate Public ToutingTable with"
  type        = string
  default = ""
}

variable "public_rt_name" {
  description = "Public RoutingTable name values"
  type = string
  default = ""
}

variable "ngw_id" {
  description = "ID of the Internet GateWay to associate Private ToutingTable with"
  type        = string
  default = ""
}

variable "private_rt_name" {
  description = "Private RoutingTable name values"
  type = string
  default = ""
}

variable "public_subnet_cidr" {
  description = "RoutingTable CIDR values"
  type        = list(string)
  default     = []
}

variable "public_subnet_id" {
  description = "RoutingTable CIDR values"
  type        = list(string)
  default     = []
}

variable "public_rt_id" {
  description = "RoutingTable CIDR values"
  type = string
  default = ""
}

variable "web_subnet_cidr" {
  description = "RoutingTable CIDR values"
  type        = list(string)
  default     = []
}

variable "web_subnet_id" {
  description = "RoutingTable CIDR values"
  type        = list(string)
  default     = []
}

variable "was_subnet_cidr" {
  description = "RoutingTable CIDR values"
  type        = list(string)
  default     = []
}

variable "was_subnet_id" {
  description = "RoutingTable CIDR values"
  type        = list(string)
  default     = []
}

variable "db_subnet_cidr" {
  description = "RoutingTable CIDR values"
  type        = list(string)
  default     = []
}

variable "db_subnet_id" {
  description = "RoutingTable CIDR values"
  type        = list(string)
  default     = []
}

variable "private_rt_id" {
  description = "RoutingTable CIDR values"
  type = string
  default = ""
}