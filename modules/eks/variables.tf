variable "cluster_role_name" {
  description = "IAM Role Name Values for EKS Cluster"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "EKS Cluster Name Values"
  type        = string
  default     = ""
}

variable "node_group_role_name" {
  description = "IAM Role Name Values for EKS Node Group"
  type        = string
  default     = ""
}

variable "cluster_subnet_ids" {
  description = "Subnet CIDR Values for EKS Cluster"
  type        = list(string)
  default     = []
}

variable "web_node_group_name" {
  description = "IAM Role Name Values for EKS Web Node Group"
  type        = string
  default     = ""
}

variable "web_node_group_subnet_ids" {
  description = "Subnet CIDR Values for EKS Web Node Group"
  type        = list(string)
  default     = []
}

variable "was_node_group_name" {
  description = "IAM Role Name Values for EKS WAS Node Group"
  type        = string
  default     = ""
}

variable "was_node_group_subnet_ids" {
  description = "Subnet CIDR Values for EKS WAS Node Group"
  type        = list(string)
  default     = []
}

variable "web_scaling_config" {
  description = "List of Scaling Config for Web Node Group"
  type        = list(object({
    desired_size = number
    max_size     = number
    min_size     = number
  }))
  default     = []
}

variable "was_scaling_config" {
  description = "List of Scaling Configs for WAS Node Group"
  type        = list(object({
    desired_size = number
    max_size     = number
    min_size     = number
  }))
  default     = []
}

variable "web_max_unavailable" {
  description = "Max Number of unavailable Nodes during an EKS Node Group Update"
  type        = string
  default     = ""
}

variable "was_max_unavailable" {
  description = "Max Number of unavailable Nodes during an EKS Node Group Update"
  type        = string
  default     = ""
}