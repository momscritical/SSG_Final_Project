#################################### AWS Values ####################################
variable "region" {
  description = "AWS region Values"
  type        = string
  default     = "ap-northeast-1"
  sensitive = true
}

#################################### VPC Values ####################################
variable "availability_zones" {
  description = "Availability Zones Values"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1c"]
  sensitive   = true
}

variable "vpc_config" {
  description = "Configuration Values for VPC"
  type        = object({
    name = string
    cidr = string
  })
  default     = {
    name = "Final-VPC"
    cidr = "10.0.0.0/16"
  }
  sensitive   = true
}

variable "public_subnet_config" {
  description = "Subnets Configuration Values for Public"
  type        = object({
    name = string
    cidr = list(string)
  })
  default     = {
    name = "Public-Subnet"
    cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  }
  sensitive   = true
}

variable "cp_subnet_config" {
  description = "Subnets Configuration Values for Web Node"
  type        = object({
    name = string
    cidr = list(string)
  })
  default     = {
    name = "Web-Subnet"
    cidr = ["10.0.3.0/24", "10.0.4.0/24"]
  }
  sensitive   = true
}

variable "app_subnet_config" {
  description = "Subnets Configuration Values for Application Node"
  type        = object({
    name = string
    cidr = list(string)
  })
  default     = {
    name = "App-Subnet"
    cidr = ["10.0.11.0/24", "10.0.12.0/24"]
  }
  sensitive   = true
}

variable "set_subnet_config" {
  description = "Subnets Configuration Values for Setting Node"
  type        = object({
    name = string
    cidr = list(string)
  })
  default     = {
    name = "Set-Subnet"
    cidr = ["10.0.101.0/24", "10.0.102.0/24"]
  }
  sensitive   = true
}

variable "db_subnet_config" {
  description = "Subnets Configuration Values for Database"
  type        = object({
    name = string
    cidr = list(string)
  })
  default     = {
    name = "DB-Subnet"
    cidr = ["10.0.201.0/24", "10.0.202.0/24"]
  }
  sensitive   = true
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
variable "bastion_sg_config" {
  description = "Security Group Configuration Values for Bastion Instance"
  type        = object({
    name     = string
    ing_port = list(number)
  })
  default     = {
    name     = "Bastion-SG"
    ing_port = [22]
  }
  sensitive   = true
}

variable "cp_sg_config" {
  description = "Security Group Configuration Values for Control Plane"
  type        = object({
    name     = string
    ing_port = list(number)
  })
  default     = {
    name     = "CP-SG"
    ing_port = [22]
  }
  sensitive   = true
}

variable "app_sg_config" {
  description = "Security Group Configuration Values for Application Nodes"
  type        = object({
    name     = string
    ing_port = list(number)
  })
  default     = {
    name     = "Application-SG"
    ing_port = [22, 80]
  }
  sensitive   = true
}

variable "set_sg_config" {
  description = "Security Group Configuration Values for Setting Nodes"
  type        = object({
    name     = string
    ing_port = list(number)
  })
  default     = {
    name     = "Set-SG"
    ing_port = [22]
  }
  sensitive   = true
}

variable "db_sg_config" {
  description = "Security Group Configuration Values for AWS RDS"
  type        = object({
    name     = string
    ing_port = list(number)
  })
  default     = {
    name     = "DataBase-SG"
    ing_port = [3306]
  }
  sensitive   = true
}

variable "elb_sg_config" {
  description = "Security Group Configuration Values for External Load Balancer"
  type        = object({
    name     = string
    ing_port = list(number)
  })
  default     = {
    name     = "Ext-LB-SG"
    ing_port = [80]
  }
  sensitive   = true
}

#################################### Key Pair Values ####################################
variable "key_config" {
  description = "Configuration Values for SSH Key Pair"
  type = object({
    name                = string
    public_key_location = string
    tags                = string
  })
  default = {
    name                = "final-key"
    public_key_location = "~/.ssh/final-key.pub"
    tags                = "Final-Key"
  }
  sensitive = true
}

#################################### EC2 Values ####################################
variable "bastion_config" {
  description = "Configuration Values for the Bastion Instance"
  type = object({
    instance_types = string
    name           = string
    user_data      = string
  })
  default = {
    instance_types = "t2.medium"
    name           = "Bastion"
    user_data      = "./user_data_file/user_data_bastion.sh"
  }
}

variable "cp_config" {
  description = "Configuration Values for the Control Plane Instance"
  type = object({
    instance_types = string
    name           = string
    user_data      = string
  })
  default = {
    instance_types = "t2.medium"
    name           = "Control-Plane"
    user_data      = "./user_data_file/user_data_cp.sh"
  }
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

variable "k8s_version" {
  description = "Version Values for Cluster"
  type        = string
  default     = "1.29"
}

variable "node_group_role_name" {
    description = "Role Name Value for Node Group"
    type        = string
    default     = "SSG-Final-2-NodeGroup-Role"
}

variable "app_node_config" {
  description = "Configuration Values for the Application Node Group"
  type = object({
    name            = string
    instance_types  = string
    desired_size    = number
    max_size        = number
    min_size        = number
    max_unavailable = number
    taint_key       = string
    taint_value     = string
    taint_effect    = string
    environment     = string
    asg_tag         = string
  })
  default = {
    name            = "App-Node-Group"
    instance_types  = "t2.medium"
    desired_size    = 2
    max_size        = 3
    min_size        = 1
    max_unavailable = 1
    taint_key       = "app"
    taint_value     = "true"
    taint_effect    = "NO_SCHEDULE"
    environment     = "production"
    asg_tag         = "App-Node"
  }
}

variable "set_node_config" {
  description = "Configuration Values for the Setting Node Group"
  type = object({
    name            = string
    instance_types  = string
    desired_size    = number
    max_size        = number
    min_size        = number
    max_unavailable = number
    taint_key       = string
    taint_value     = string
    taint_effect    = string
    environment     = string
    asg_tag         = string
  })
  default = {
    name            = "Setting-Node-Group"
    instance_types  = "t2.medium"
    desired_size    = 2
    max_size        = 3
    min_size        = 1
    max_unavailable = 1
    taint_key       = "setting"
    taint_value     = "true"
    taint_effect    = "NO_SCHEDULE"
    environment     = "production"
    asg_tag         = "Setting-Node"
  }
}

#################################### Ingress Controller Values ####################################
variable "ingress_controller_yaml" {
  description = "Location Values about Ingress Controller Manifest File"
  type        = string
  default     = "./yaml/ingress-controller.yaml"
  sensitive   = true
}

#################################### IRSA Values ####################################
variable "service_account_name" {
  description = "Name Values for EKS Service Account"
  type = list(string)
  default = ["system:serviceaccount:dev:s3-sa"]
}

variable "oidc_role_name" {
  description = "Cluster OIDC URL Values"
  type = string
  default = "ssg-final-3-oidc-s3-role"
}

#################################### AWS RDS Values ####################################
variable "rds_config" {
  description = "Configuration Values for AWS RDS"
  type = object({
    name                  = string
    storage               = number
    max_storage           = number
    engine_type           = string
    engine_version        = string
    instance_class        = string
    db_name               = string
    db_user_name          = string
    db_user_pass          = string
    multi_az              = bool
    publicly_accessible   = bool
    skip_final_snapshot   = bool
    rds_subnet_group_name = string
  })
  default = {
    name                  = "final-rds"
    storage               = 50
    max_storage           = 100
    engine_type           = "mysql"
    engine_version        = "8.0.35"
    instance_class        = "db.m5d.large"
    db_name               = "coupang"
    db_user_name          = "root"
    db_user_pass          = "admin12345"
    multi_az              = true
    publicly_accessible   = false
    skip_final_snapshot   = true
    rds_subnet_group_name = "rds-subnet-group"
  }
  sensitive = true
}