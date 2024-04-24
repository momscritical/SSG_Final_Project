variable "ami" {
  description = "The AMI for Bastion Instance"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The Instance Type for Bastion Instance"
  type        = string
  default     = ""

}

variable "bastion_sg_id" {
  description = "Security Group ID for Bastion Instance"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "Key Pair Name Values"
  type        = string
  default     = ""
}

variable "bastion_subnet_id" {
  description = "Subnet ID for Bastion Instance"
  type        = string
  default     = ""
}

variable "bastion_user_data" {
  description = "The User Data Script for Bastion Instance"
  type        = string
  default     = ""
}

variable "bastion_name" {
  description = "The name tag for the Bastion Instance"
  type        = string
  default     = ""
}

variable "control_plane_sg_id" {
  description = "Security Group ID for EKS Control Plane"
  type        = list(string)
  default     = []
}

variable "control_plane_subnet_id" {
  description = "Subnet ID for EKS Control Plane"
  type        = string
  default     = ""
}

variable "control_plane_user_data" {
  description = "The User Data Script for EKS Control Plane"
  type        = string
  default     = ""
}

variable "control_plane_name" {
  description = "The name tag for EKS Control Plane"
  type        = string
  default     = ""
}