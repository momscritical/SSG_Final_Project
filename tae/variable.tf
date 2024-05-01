#################################### VPC ####################################
variable "region" {
    description = "AWS region Values"
    type        = string
    default     = "ap-northeast-1"
}

variable "vpc_cidr" {
    description = "VPC CIDR Values"
    type    = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "Public Subnet CIDR values"
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "web_subnet_cidr" {
    description = "Subnet CIDR values for EKS Web Nodes"
    type        = list(string)
    default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "was_subnet_cidr" {
    description = "Subnet CIDR Values for EKS WAS Nodes"
    type        = list(string)
    default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "set_subnet_cidr" {
    description = "Subnet CIDR Values for EKS Setting Nodes"
    type        = list(string)
    default     = ["10.0.103.0/24", "10.0.104.0/24"]
}

variable "db_subnet_cidr" {
    description = "Subnet CIDR Values for RDS"
    type        = list(string)
    default     = ["10.0.201.0/24", "10.0.202.0/24"]
}

variable "availability_zones" {
    description = "Availability Zones Values"
    type        = list(string)
    default     = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "vpc_name" {
    description = "VPC Name Values"
    type    = string
    default = "Final-VPC"
}

variable "public_subnet_name" {
    description = "Public Subnets name values"
    type        = string
    default     = "Public-Subnet"
}

variable "web_subnet_name" {
  description = "Web Subnets Name Values"
  type        = string
  default     = "Web-Subnet"
}

variable "was_subnet_name" {
    description = "WAS Subnets Name Values"
    type        = string
    default     = "WAS-Subnet"
}

variable "set_subnet_name" {
    description = "Set Subnets Name Values"
    type        = string
    default     = "Set-Subnet"
}

variable "db_subnet_name" {
    description = "DataBase Subnets name values"
    type        = string
    default     = "DB-Subnet"
}

variable "igw_name" {
    description = "Internet Gateway name values"
    type        = string
    default     = "Internet-Gateway"
}

variable "ngw_name" {
    description = "NAT Gateway name values"
    type        = string
    default     = "NAT-Gateway"
}

variable "public_rt_name" {
    description = "Public Routing Table name values"
    type        = string
    default     = "Public-Routing-Table"
}

variable "private_rt_name" {
  description = "Private Routing Table name values"
  type        = string
  default     = "Private-Routing-Table"
}

variable "enable_dns_hostnames" {
    description = "Whether to enable DNS hostnames for the VPC"
    type        = bool
    default     = true
}

variable "enable_dns_support" {
    description = "Whether to enable DNS support for the VPC"
    type        = bool
    default     = true
}

#################################### Security Group ####################################
variable "bastion_sg_name" {
    description = "The Name of the Security Group for Bastion Instance"
    type        = string
    default     = "Bastion-SG"
}

variable "web_sg_name" {
    description = "The Name of the Security Group for Web Nodes"
    type        = string
    default     = "Web-SG"
}

variable "was_sg_name" {
    description = "The Name of the Security Group for WAS Nodes"
    type        = string
    default     = "WAS-SG"
}

variable "set_sg_name" {
    description = "The Name of the Security Group for Setting Nodes"
    type        = string
    default     = "WAS-SG"
}

variable "db_sg_name" {
    description = "The Name of the Security Group for DataBase"
    type        = string
    default     = "DataBase-SG"
}

variable "elb_sg_name" {
    description = "The Name of the Security Group External Load Balancer"
    type        = string
    default     = "Ext-LB-SG"
}

variable "ilb_sg_name" {
    description = "The Name of the Security Group Internal Load Balancer"
    type        = string
    default     = "Int-LB-SG"
}

variable "web_efs_sg_name" {
    description = "The Name of the Security Group for Web EFS"
    type        = string
    default     = "Web-EFS-SG"
}

variable "was_efs_sg_name" {
    description = "The Name of the Security Group for WAS EFS"
    type        = string
    default     = "WAS-EFS-SG"
}

variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
    default     = ""
}

# variable "bastion_ing_rules" {
#   description = "Ingress rules for the bastion security group"
#   type        = list(object({
#     from_port       = number
#     to_port         = number
#     security_groups = list(string)
#     cidr_blocks     = list(string)
#     description     = string
#     protocol        = string
#   }))
#   default = [
#     {
#       from_port = 22
#       to_port   = 22
#       protocol  = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#       description = "Allow SSH access from anywhere"
#     }
#   ]
# }

variable "bastion_ing_rules" {
  description = "List of ingress rules for Bastion Instance"
  type        = list(object({
    from_port   = number
    to_port     = number
  }))
  default     = [
    {
      from_port = 22
      to_port   = 22
    },
    {
      from_port = 3000
      to_port   = 3000
    },
    {
      from_port = 9090
      to_port   = 9090
    }
  ]
}

variable "web_ing_rules" {
  description = "List of ingress rules for Web Instance"
  type        = list(object({
    from_port       = number
    to_port         = number
    security_groups = list(string)
  }))
  default     = [
    {
      from_port       = 22
      to_port         = 22
      security_groups = [module.final_sg.bastion_sg_id]
    },
    {
      from_port       = 5000
      to_port         = 5000
      security_groups = [module.final_sg.elb_sg_id]
    },
    {
      from_port       = 9100
      to_port         = 9100
      security_groups = [module.final_sg.bastion_sg_id]
    }
  ]
}

variable "was_ing_rules" {
  description = "List of ingress rules for WAS Instance"
  type        = list(object({
    from_port       = number
    to_port         = number
    security_groups = list(string)
  }))
  default     = [
    {
      from_port       = 22
      to_port         = 22
      security_groups = [module.final_sg.bastion_sg_id]
    },
    {
      from_port       = 5000
      to_port         = 5000
      security_groups = [module.final_sg.ilb_sg_id]
    },
    {
      from_port       = 9100
      to_port         = 9100
      security_groups = [module.final_sg.bastion_sg_id]
    }
  ]
}

variable "db_ing_rules" {
  description = "List of ingress rules for DataBase"
  type        = list(object({
    from_port       = number
    to_port         = number
    security_groups = list(string)
  }))
  default     = [
    {
      from_port       = 3306
      to_port         = 3306
      security_groups = [module.final_sg.web_sg_id]
    },
    {
      from_port       = 3306
      to_port         = 3306
      security_groups = [module.final_sg.was_sg_id]
    }
  ]
}

variable "elb_ing_rules" {
  description = "List of ingress rules for External Load Balancer"
  type        = list(object({
    from_port       = number
    to_port         = number
  }))
  default     = [
    {
      from_port = 80
      to_port   = 80
    }
  ]
}

variable "ilb_ing_rules" {
  description = "List of ingress rules for Internal Load Balancer"
  type        = list(object({
    from_port       = number
    to_port         = number
    security_groups = list(string)
  }))
  default     = [
    {
      from_port       = 5000
      to_port         = 5000
      security_groups = [module.final_sg.web_sg_id]
    }
  ]
}

variable "web_efs_ing_rules" {
  description = "List of ingress rules for Web EFS"
  type        = list(object({
    from_port       = number
    to_port         = number
    security_groups = list(string)
  }))
  default     = [
    {
      from_port       = 2049
      to_port         = 2049
      security_groups = [module.final_sg.web_sg_id]
    }
  ]
}

variable "was_efs_ing_rules" {
  description = "List of ingress rules for WAS EFS"
  type        = list(object({
    from_port       = number
    to_port         = number
    security_groups = list(string)
  }))
  default     = [
    {
      from_port       = 2049
      to_port         = 2049
      security_groups = [module.final_sg.was_sg_id]
    }
  ]
}

