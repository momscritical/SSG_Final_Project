variable "vpc_id" {
  description = "The ID of the VPC"
  type = string
  default = ""
}

variable "bastion_sg_name" {
  description = "The Name of the Security Group for Bastion Instance"
  type = string
  default = ""
}

variable "web_sg_name" {
  description = "The Name of the Security Group for Web Instance"
  type = string
  default = ""
}

variable "was_sg_name" {
  description = "The Name of the Security Group for WAS Instance"
  type = string
  default = ""
}

variable "db_sg_name" {
  description = "The Name of the Security Group for DataBase"
  type = string
  default = ""
}

variable "elb_sg_name" {
  description = "The Name of the Security Group External Load Balancer"
  type = string
  default = ""
}

variable "ilb_sg_name" {
  description = "The Name of the Security Group Internal Load Balancer"
  type = string
  default = ""
}

variable "web_efs_sg_name" {
  description = "The Name of the Security Group for Web EFS"
  type = string
  default = ""
}

variable "was_efs_sg_name" {
  description = "The Name of the Security Group for WAS EFS"
  type = string
  default = ""
}

variable "bastion_ing_ports" {
  description = "List of Ingress Ports for Bastion"
  type        = list(number)
  default     = []
}

variable "web_ing_ports" {
  description = "List of Ingress Ports for Web"
  type        = list(number)
  default     = []
}

variable "was_ing_ports" {
  description = "List of Ingress Ports for WAS"
  type        = list(number)
  default     = []
}

variable "db_ing_ports" {
  description = "List of Ingress Ports for DataBase"
  type        = list(number)
  default     = []
}

variable "elb_ing_ports" {
  description = "List of Ingress Ports for External Loadbalancer"
  type        = list(number)
  default     = []
}

variable "ilb_ing_ports" {
  description = "List of Ingress Ports for Internal Loadbalancer"
  type        = list(number)
  default     = []
}

variable "web_efs_ing_ports" {
  description = "List of Ingress Ports for Web EFS"
  type        = list(number)
  default     = []
}

variable "was_efs_ing_ports" {
  description = "List of Ingress Ports for WAS EFS"
  type        = list(number)
  default     = []
}