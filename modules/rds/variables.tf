variable "rds_name" {
  description = "RDS Name Value"
  type        = string
  default     = ""
}

variable "storage" {
  description = "The Size of Allocated Storage"
  type        = number
  default     = 50
}

variable "max_storage" {
  description = "The Minimum Size of Allocated Storage"
  type        = number
  default     = 100
}

variable "engine_type" {
  description = "RDS Engine Type Value"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "RDS Engine Type Value"
  type        = string
  default     = "8.0.35"
}

variable "instance_class" {
  description = "RDS Engine Instance Class Value"
  type        = string
  default     = "db.t2.micro"
}

variable "db_name" {
  description = "Initial Data Base Name Value"
  type        = string
  default     = "ssg"
  sensitive   = true
}

variable "db_user_name" {
  description = "Data Base User Name Value"
  type        = string
  default     = "nana"
  sensitive   = true
}

variable "db_user_pass" {
  description = "Data Base User PassWord Value"
  type        = string
  default     = "Nana!12345"
  sensitive   = true
}

variable "db_sg_ids" {
  description = "Data Base Subnet CIDR Values"
  type        = list(string)
  default     = []
}

variable "rds_subnet_group_name" {
  description = "Data Base User PassWord Value"
  type        = string
  default     = ""
}

variable "rds_subnet_ids" {
  description = "Data Base Subnet CIDR Values"
  type        = list(string)
  default     = []
}