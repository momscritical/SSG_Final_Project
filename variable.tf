variable "bastion_vpc_cidr" { 
  description = "The CIDR Block for the Bastion VPC." 
  type        = string 
  default     = "100.0.0.0/16" 
}

variable "service_vpc_cidr" { 
  description = "The CIDR Block for the Service VPC." 
  type        = string 
  default     = "101.0.0.0/16" 
}

variable "db_vpc_cidr" { 
  description = "The CIDR Block for the DB VPC." 
  type        = string 
  default     = "102.0.0.0/16" 
}