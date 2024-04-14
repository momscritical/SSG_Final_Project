variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = ""
}

variable "ext_lb_name" {
  description = "Enternal Laod Balancer Name Value"
  type = string
  default = ""
}

variable "ext_tg_name" {
  description = "Enternal LaodBalancer Name Value"
  type = string
  default = ""
}

variable "int_lb_name" {
  description = "Internal Laod Balancer Name Value"
  type = string
  default = ""
}

variable "int_tg_name" {
  description = "Enternal LaodBalancer Name Value"
  type = string
  default = ""
}

variable "public_subnet_id" {
  description = "Subnet ID for Enternal LaodBalancer"
  type        = list(string)
  default     = []
}

variable "web_subnet_id" {
  description = "Subnet ID for Internal LaodBalancer"
  type        = list(string)
  default     = []
}

variable "ext_sg_id" {
  description = "External Security Group ID Values for Enternal LaodBalancer"
  type        = list(string)
  default     = []
}

variable "int_sg_id" {
  description = "External Security Group ID Values for Enternal LaodBalancer"
  type        = list(string)
  default     = []
}

variable "ext_listener_port" {
  description = "Port Values for Enternal LaodBalancer Listener"
  type = string
  default = ""
}

variable "ext_listener_protocol" {
  description = "Protocol Values for Enternal LaodBalancer Listener"
  type = string
  default = ""
}

variable "ext_tg_port" {
  description = "Port Values for Enternal LaodBalancer Listener"
  type = string
  default = ""
}

variable "ext_tg_protocol" {
  description = "Protocol Values for Enternal LaodBalancer Listener"
  type = string
  default = ""
}

variable "int_listener_port" {
  description = "Port Values for Enternal LaodBalancer Listener"
  type = string
  default = ""
}

variable "int_listener_protocol" {
  description = "Protocol Values for Enternal LaodBalancer Listener"
  type = string
  default = ""
}

variable "int_tg_port" {
  description = "Port Values for Enternal LaodBalancer Listener"
  type = string
  default = ""
}

variable "int_tg_protocol" {
  description = "Protocol Values for Enternal LaodBalancer Listener"
  type = string
  default = ""
}