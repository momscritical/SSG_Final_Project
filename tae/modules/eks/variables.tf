################################### Cluster Role ###################################
variable "cluster_role_name" {
  description = "IAM Role Name Values for EKS Cluster"
  type        = string
  default     = ""
}

################################### Cluster  ###################################
variable "cluster_name" {
  description = "EKS Cluster Name Values"
  type        = string
  default     = ""
}

variable "k8s_version" {
  description = "IAM Role Name Values for EKS Cluster"
  type        = string
  default     = "1.29.0"
}

variable "cluster_subnet_ids" {
  description = "Subnet CIDR Values for EKS Cluster"
  type        = list(string)
  default     = []
}

################################# Node group Role #################################
variable "node_group_role_name" {
  description = "IAM Role Name Values for EKS Node Group"
  type        = string
  default     = ""
}

################################### Application Nodes ###################################
variable "app_node_group_name" {
  description = "Name Values for EKS Application Node Group"
  type        = string
  default     = ""
}

variable "app_node_group_subnet_ids" {
  description = "Subnet CIDR Values for EKS Application Node Group"
  type        = list(string)
  default     = []
}

variable "app_instance_types" {
  description = "List of Instance Types for Application Servers"
  type        = list(string)
  default     = [ "t2.small" ]
}

variable "app_node_group_desired_size" {
  description = "The Desired Number of Application Nodes"
  type        = number
  default     = 2
}

variable "app_node_group_max_size" {
  description = "The Maximum Number of Application Nodes"
  type        = number
  default     = 3
}

variable "app_node_group_min_size" {
  description = "The Minimum Number of Application Nodes"
  type        = number
  default     = 1
}

variable "app_max_unavailable" {
  description = "Max Number of unavailable Nodes during an EKS Node Group Update"
  type        = string
  default     = ""
}

variable "app_taint_key" {
  description = "Taint Key Variable for Application Node"
  type        = string
  default     = "app"
}

variable "app_taint_value" {
  description = "Taint Value Variable for Application Node"
  type        = string
  default     = "true"
}

variable "app_taint_effect" {
  description = "Taint Effect Variable Application Node"
  type        = string
  default     = "NO_SCHEDULE"
}

variable "app_environment" {
  description = "Name Values for Application Node Group"
  type        = string
  default     = "production"
}

variable "app_asg_tag" {
  description = "Name Values for Application Node Group"
  type        = string
  default     = "App-Node"
}

############################## Setting Node ##############################
variable "set_node_group_name" {
  description = "Name Values for EKS Setting Node Group"
  type        = string
  default     = ""
}

variable "set_node_group_subnet_ids" {
  description = "Subnet CIDR Values for EKS Setting Node Group"
  type        = list(string)
  default     = []
}

variable "set_instance_types" {
  description = "List of Instance Types for EKS Setting Node"
  type        = list(string)
  default     = [ "t2.small" ]
}

variable "set_node_group_desired_size" {
  description = "The Desired Number of EKS Setting Node"
  type        = number
  default     = 2
}

variable "set_node_group_max_size" {
  description = "The Maximum Number of EKS Setting Node"
  type        = number
  default     = 3
}

variable "set_node_group_min_size" {
  description = "The Minimum Number of EKS Setting Node"
  type        = number
  default     = 1
}

variable "set_max_unavailable" {
  description = "Max Number of unavailable Nodes during an EKS Node Group Update"
  type        = string
  default     = ""
}

variable "set_environment" {
  description = "Name Values for EKS Setting Node"
  type        = string
  default     = "production"
}

variable "set_asg_tag" {
  description = "Name Values for EKS Setting Node"
  type        = string
  default     = "Set-Node"
}

variable "yaml_dir" {
  description = "Location of the Ingress Nginx Controller"
  type        = string
  default     = "./yaml"
  sensitive = true
}

variable "region" {
  description = "Region Values"
  type        = string
  default     = ""
}

# ################################### WAS Nodes ###################################
# variable "was_node_group_name" {
#   description = "Name Values for EKS WAS Node Group"
#   type        = string
#   default     = ""
# }

# variable "was_node_group_subnet_ids" {
#   description = "Subnet CIDR Values for EKS WAS Node Group"
#   type        = list(string)
#   default     = []
# }

# variable "was_instance_types" {
#   description = "List of Instance Types for WAS Servers"
#   type        = list(string)
#   default     = [ "t2.small" ]
# }

# variable "was_node_group_desired_size" {
#   description = "The Desired Number of WAS Nodes"
#   type        = number
#   default     = 2
# }

# variable "was_node_group_max_size" {
#   description = "The Maximum Number of WAS Nodes"
#   type        = number
#   default     = 3
# }

# variable "was_node_group_min_size" {
#   description = "The Minimum Number of WAS Nodes"
#   type        = number
#   default     = 1
# }

# variable "was_max_unavailable" {
#   description = "Max Number of unavailable Nodes during an EKS Node Group Update"
#   type        = string
#   default     = ""
# }

# variable "was_taint_key" {
#   description = "Web Taint Key Variable"
#   type        = string
#   default     = "was"
# }

# variable "was_taint_value" {
#   description = "WAS Taint Value Variable"
#   type        = string
#   default     = "true"
# }

# variable "was_taint_effect" {
#   description = "WAS Taint Effect Variable"
#   type        = string
#   default     = "NO_SCHEDULE"
# }

# variable "was_environment" {
#   description = "Name Values for EKS WAS Node Group"
#   type        = string
#   default     = "production"
# }

# variable "was_asg_tag" {
#   description = "Name Values for EKS WAS Node Group"
#   type        = string
#   default     = "WAS-Node"
# }