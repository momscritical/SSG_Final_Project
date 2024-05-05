#################################### Bastion Values ####################################
variable "bastion_ami" {
  description = "The AMI for Bastion Instance"
  type        = string
  default     = ""
}

variable "bastion_instance_type" {
  description = "The Instance Type for Bastion Instance"
  type        = string
  default     = ""

}

variable "bastion_sg_id" {
  description = "Security Group ID for Bastion Instance"
  type        = list(string)
  default     = []
}

variable "bastion_key_name" {
  description = "Key Pair Name Values for Bastion Instance"
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

#################################### Control Plane Values ####################################
variable "cp_ami" {
  description = "The AMI for Control Plane Instance"
  type        = string
  default     = ""
}

variable "cp_instance_type" {
  description = "The Instance Type for Control Plane Instance"
  type        = string
  default     = ""

}

variable "cp_sg_id" {
  description = "Security Group ID for Control Plane Instance"
  type        = list(string)
  default     = []
}

variable "cp_key_name" {
  description = "Key Pair Name Values for Control Plane Instance"
  type        = string
  default     = ""
}

variable "cp_subnet_id" {
  description = "Subnet ID for Control Plane Instance"
  type        = string
  default     = ""
}

variable "cp_user_data" {
  description = "The User Data Script for Control Plane Instance"
  type        = string
  default     = ""
}

variable "cp_name" {
  description = "The name tag for Control Plane Instance"
  type        = string
  default     = ""
}