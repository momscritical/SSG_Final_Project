variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = ""
}

#################################### Name Values ####################################
variable "bastion_sg_name" {
  description = "The Name of the Security Group for Bastion Instance"
  type        = string
  default     = ""
}

variable "cp_sg_name" {
  description = "The Name of the Security Group for Control Plane"
  type        = string
  default     = ""
}

variable "app_sg_name" {
  description = "The Name of the Security Group for Web Instance"
  type        = string
  default     = ""
}

variable "set_sg_name" {
  description = "The Name of the Security Group for EKS Setting Node"
  type        = string
  default     = ""
}

variable "db_sg_name" {
  description = "The Name of the Security Group for DataBase"
  type        = string
  default     = ""
}

variable "elb_sg_name" {
  description = "The Name of the Security Group External Load Balancer"
  type        = string
  default     = ""
}

variable "cluster_sg_name" {
  description = "The Name of the Security Group for EKS Cluster"
  type        = string
  default     = ""
}

#################################### Ingress Ports Values ####################################
variable "bastion_ing_rules" {
  description = "List of ingress rules for Bastion Instance"
  type        = list(object({
    from_port       = number
    to_port         = number
  }))
  default     = []
}

variable "cp_ing_rules" {
  description = "List of ingress rules for Control Plane"
  type        = list(object({
    from_port       = number
    to_port         = number
    security_groups = list(string)
  }))
  default     = []
}

variable "app_ing_rules" {
  description = "List of ingress rules for Application Nodes"
  type        = list(object({
    from_port       = number
    to_port         = number
    security_groups = list(string)
  }))
  default     = []
}

variable "set_ing_rules" {
  description = "List of ingress rules for EKS Setting Node"
  type        = list(object({
    from_port       = number
    to_port         = number
    security_groups = list(string)
  }))
  default     = []
}

variable "db_ing_rules" {
  description = "List of ingress rules for DataBase"
  type        = list(object({
    from_port       = number
    to_port         = number
    security_groups = list(string)
  }))
  default     = []
}

variable "elb_ing_rules" {
  description = "List of ingress rules for External Load Balancer"
  type        = list(object({
    from_port       = number
    to_port         = number
  }))
  default     = []
}

variable "cluster_ing_rules" {
  description = "List of ingress rules for WAS EKS Cluster"
  type        = list(object({
    from_port       = number
    to_port         = number
    security_groups = list(string)
  }))
  default     = []
}