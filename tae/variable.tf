#################################### VPC Values ####################################
variable "region" {
    description = "AWS region Values"
    type        = string
    default     = "ap-northeast-3"
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
    default     = ["${var.region}a", "${var.region}c"]
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

#################################### Security Group Values ####################################
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
#   }))
#   default = [
#     {
#       from_port = 22
#       to_port   = 22
#     }
#   ]
# }

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

# variable "bastion_ing_rules" {
#   description = "List of ingress rules for Bastion Instance"
#   type        = list(object({
#     from_port   = number
#     to_port     = number
#   }))
#   default     = [
#     {
#       from_port = 22
#       to_port   = 22
#     },
#     {
#       from_port = 3000
#       to_port   = 3000
#     },
#     {
#       from_port = 9090
#       to_port   = 9090
#     }
#   ]
# }

# variable "web_ing_rules" {
#   description = "List of ingress rules for Web Instance"
#   type        = list(object({
#     from_port       = number
#     to_port         = number
#     security_groups = list(string)
#   }))
#   default     = [
#     {
#       from_port       = 22
#       to_port         = 22
#       security_groups = [module.final_sg.bastion_sg_id]
#     },
#     {
#       from_port       = 5000
#       to_port         = 5000
#       security_groups = [module.final_sg.elb_sg_id]
#     },
#     {
#       from_port       = 9100
#       to_port         = 9100
#       security_groups = [module.final_sg.bastion_sg_id]
#     }
#   ]
# }

# variable "was_ing_rules" {
#   description = "List of ingress rules for WAS Instance"
#   type        = list(object({
#     from_port       = number
#     to_port         = number
#     security_groups = list(string)
#   }))
#   default     = [
#     {
#       from_port       = 22
#       to_port         = 22
#       security_groups = [module.final_sg.bastion_sg_id]
#     },
#     {
#       from_port       = 5000
#       to_port         = 5000
#       security_groups = [module.final_sg.ilb_sg_id]
#     },
#     {
#       from_port       = 9100
#       to_port         = 9100
#       security_groups = [module.final_sg.bastion_sg_id]
#     }
#   ]
# }

# variable "db_ing_rules" {
#   description = "List of ingress rules for DataBase"
#   type        = list(object({
#     from_port       = number
#     to_port         = number
#     security_groups = list(string)
#   }))
#   default     = [
#     {
#       from_port       = 3306
#       to_port         = 3306
#       security_groups = [module.final_sg.web_sg_id]
#     },
#     {
#       from_port       = 3306
#       to_port         = 3306
#       security_groups = [module.final_sg.was_sg_id]
#     }
#   ]
# }

# variable "elb_ing_rules" {
#   description = "List of ingress rules for External Load Balancer"
#   type        = list(object({
#     from_port       = number
#     to_port         = number
#   }))
#   default     = [
#     {
#       from_port = 80
#       to_port   = 80
#     }
#   ]
# }

# variable "ilb_ing_rules" {
#   description = "List of ingress rules for Internal Load Balancer"
#   type        = list(object({
#     from_port       = number
#     to_port         = number
#     security_groups = list(string)
#   }))
#   default     = [
#     {
#       from_port       = 5000
#       to_port         = 5000
#       security_groups = [module.final_sg.web_sg_id]
#     }
#   ]
# }

# variable "web_efs_ing_rules" {
#   description = "List of ingress rules for Web EFS"
#   type        = list(object({
#     from_port       = number
#     to_port         = number
#     security_groups = list(string)
#   }))
#   default     = [
#     {
#       from_port       = 2049
#       to_port         = 2049
#       security_groups = [module.final_sg.web_sg_id]
#     }
#   ]
# }

# variable "was_efs_ing_rules" {
#   description = "List of ingress rules for WAS EFS"
#   type        = list(object({
#     from_port       = number
#     to_port         = number
#     security_groups = list(string)
#   }))
#   default     = [
#     {
#       from_port       = 2049
#       to_port         = 2049
#       security_groups = [module.final_sg.was_sg_id]
#     }
#   ]
# }

#################################### Key Pair Values ####################################
variable "key_name" {
    description = "Key Pair Name Value"
    type        = string
    default     = "final-key"
    sensitive = true
}

variable "public_key_location" {
    description = "Source Public Key Location Value"
    type        = string
    default     = "~/.ssh/final-key.pub"
    sensitive = true
}

variable "key_tags" {
    description = "Key Pair Tags Value"
    type        = string
    default     = "Final-Key"
    sensitive = true
}

#################################### Bastion Values ####################################
variable "instance_type" {
    description = "Instance Type Value for Bastion"
    type        = string
    default     = "t2.small"
}

variable "bastion_user_data" {
    description = "User Data for Bastion"
    type        = string
    default     = "./user_data_file/user_data_bastion.sh"
}

variable "bastion_name" {
    description = "Name Value for Bastion"
    type        = string
    default     = "Bastion"
}

#################################### AWS Elastic Kubernetes Service Values ####################################
variable "cluster_role_name" {
    description = "Role Name Value for Cluster"
    type        = string
    default     = "SSG-Final-2-Cluster-Role"
}

variable "cluster_name" {
    description = "Name Value for Cluster"
    type        = string
    default     = "EKS-Cluster"
}

variable "node_group_role_name" {
    description = "Role Name Value for Node Group"
    type        = string
    default     = "SSG-Final-2-NodeGroup-Role"
}

# variable "web_node_group_name" {
#     description = "Name Value for Web Node Group"
#     type        = string
#     default     = "Web-Node-Group"
# }

# variable "was_node_group_name" {
#     description = "Name Value for WAS Node Group"
#     type        = string
#     default     = "WAS-Node-Group"
# }

# variable "set_node_group_name" {
#     description = "Name Value for Setting Node Group"
#     type        = string
#     default     = "Set-Node-Group"
# }

# variable "web_node_scaling_config" {
#   description = "Auto Scaling Configuration Values for the Web Node Group"
#   type = object({
#     desired_size = number
#     max_size     = number
#     min_size     = number
#   })
#   default = {
#     desired_size = 2
#     max_size     = 3
#     min_size     = 1
#   }
# }

# variable "was_node_scaling_config" {
#   description = "Auto Scaling Configuration Values for the WAS Node Group"
#   type = object({
#     desired_size = number
#     max_size     = number
#     min_size     = number
#   })
#   default = {
#     desired_size = 2
#     max_size     = 3
#     min_size     = 1
#   }
# }

# variable "set_node_scaling_config" {
#   description = "Auto Scaling Configuration Values for the Setting Node Group"
#   type = object({
#     desired_size = number
#     max_size     = number
#     min_size     = number
#   })
#   default = {
#     desired_size = 2
#     max_size     = 3
#     min_size     = 1
#   }
# }

# variable "web_max_unavailable" {
#   description = "Max Unavailable Node Values when Updating for the Web Node Group"
#   type = number
#   default = 1
# }

# variable "was_max_unavailable" {
#   description = "Max Unavailable Node Values when Updating for the WAS Node Group"
#   type = number
#   default = 1
# }

# variable "set_max_unavailable" {
#   description = "Max Unavailable Node Values when Updating for the Setting Node Group"
#   type = number
#   default = 1
# }




variable "web_node_config" {
  description = "Configuration Values for the Web Node Group"
  type = object({
    name = string
    instance_types = string
    desired_size = number
    max_size     = number
    min_size     = number
    max_unavailable = number
    taint_key = string
    taint_value = string
    taint_effect = string
    environment = string
    asg_tag = string
  })
  default = {
    name = "Web-Node-Group"
    instance_types = "t2.small"
    desired_size = 2
    max_size     = 3
    min_size     = 1
    max_unavailable = 1
    taint_key = "web"
    taint_value = "true"
    taint_effect = "NO_SCHEDULE"
    environment = "production"
    asg_tag = "Web-Node"
  }
}

variable "k8s_version" {
  description = "Version Values for Cluster"
  type = string
  default = "1.29"
}

variable "was_node_config" {
  description = "Configuration Values for the WAS Node Group"
  type = object({
    name = string
    instance_types = string
    desired_size = number
    max_size     = number
    min_size     = number
    max_unavailable = number
    taint_key = string
    taint_value = string
    taint_effect = string
    environment = string
    asg_tag = string
  })
  default = {
    name = "WAS-Node-Group"
    instance_types = "t2.small"
    desired_size = 2
    max_size     = 3
    min_size     = 1
    max_unavailable = 1
    taint_key = "was"
    taint_value = "true"
    taint_effect = "NO_SCHEDULE"
    environment = "production"
    asg_tag = "WAS-Node"
  }
}

variable "set_node_config" {
  description = "Configuration Values for the Setting Node Group"
  type = object({
    name = string
    instance_types = string
    desired_size = number
    max_size     = number
    min_size     = number
    max_unavailable = number
    taint_key = string
    taint_value = string
    taint_effect = string
    environment = string
    asg_tag = string
  })
  default = {
    name = "WAS-Node-Group"
    instance_types = "t2.small"
    desired_size = 2
    max_size     = 3
    min_size     = 1
    max_unavailable = 1
    taint_key = "was"
    taint_value = "true"
    taint_effect = "NO_SCHEDULE"
    environment = "production"
    asg_tag = "WAS-Node"
  }
}

#################################### Ingress Controller Values ####################################
variable "ingress_controller_yaml" {
  description = "Location Values about Ingress Controller Manifest File"
  type = string
  default = "./yaml/ingress-controller.yaml"
}

#################################### AWS RDS Values ####################################
variable "rds_config" {
  description = "Configuration Values for AWS RDS"
  type = object({
    rds_name = string
    storage = number
    max_storage     = number
    engine_type = string
    engine_version = string
    instance_class = string
    db_name = string
    db_user_name = string
    db_user_pass = string
    multi_az = bool
    publicly_accessible = bool
    skip_final_snapshot = bool

    rds_subnet_group_name = string
  })
  default = {
    rds_name = "final-rds"
    storage = 50
    max_storage     = 100
    engine_type = "mysql"
    engine_version = "8.0.35"
    instance_class = "db.m5d.large"
    db_name = "coupang"
    db_user_name = "root"
    db_user_pass = "admin12345"
    multi_az = true
    publicly_accessible = false
    skip_final_snapshot = true
    rds_subnet_group_name = "rds-subnet-group"
  }
}

# variable "rds_name" {
#   description = "Name Values for RDS"
#   type = string
#   default = "final-rds"
#   sensitive = true
# }


# variable "rds_name" {
#   description = "Name Values for RDS"
#   type = string
#   default = "final-rds"
#   sensitive = true
# }