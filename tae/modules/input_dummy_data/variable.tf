variable "private_key_location" {
  description = "Private Key Location values"
  type        = string
  default     = ""

  sensitive = true
}

variable "private_key_dest" {
  description = "Private Key Destination"
  type        = string
  default     = ""

  sensitive = true
}

variable "dummy_file_location" {
  description = "Dummy File Location values"
  type        = string
  default     = ""

  sensitive = true
}

variable "dummy_file_dest" {
  description = "Dummy File Destination"
  type        = string
  default     = ""

  sensitive = true
}

variable "bastion_ip" {
  description = "Bastion Public IP Values"
  type        = string
  default     = ""

  sensitive = true
}

variable "cp_ip" {
  description = "Controle Plane Private IP Values"
  type        = string
  default     = ""

  sensitive = true
}

variable "db_user_name" {
  description = "User Name Values for Database"
  type        = string
  default     = ""

  sensitive = true
}

variable "db_user_pass" {
  description = "User PassWord Values for Database"
  type        = string
  default     = ""

  sensitive = true
}

variable "rds_address" {
  description = "RDS Address Values"
  type        = string
  default     = ""

  sensitive = true
}

variable "db_name" {
  description = "Database Name Values"
  type        = string
  default     = ""

  sensitive = true
}