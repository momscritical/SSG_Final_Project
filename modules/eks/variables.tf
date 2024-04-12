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

variable "web_node_group_desired_size" {
  description = "IAM Role Name Values for EKS WAS Node Group"
  type        = number
  default     = 2
}

variable "web_node_group_max_size" {
  description = "IAM Role Name Values for EKS WAS Node Group"
  type        = number
  default     = 3
}

variable "web_node_group_min_size" {
  description = "IAM Role Name Values for EKS WAS Node Group"
  type        = number
  default     = 1
}

variable "was_node_group_desired_size" {
  description = "IAM Role Name Values for EKS WAS Node Group"
  type        = number
  default     = 2
}

variable "was_node_group_max_size" {
  description = "IAM Role Name Values for EKS WAS Node Group"
  type        = number
  default     = 3
}

variable "was_node_group_min_size" {
  description = "IAM Role Name Values for EKS WAS Node Group"
  type        = number
  default     = 1
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

variable "web_node_group_taints" {
  type = list(object({
    effect = string
    key    = string
    value  = string
  }))
  default = [
    {
      effect = "NoSchedule"
      key    = "web"
      value  = "true"
    },
  ]
}

variable "was_node_group_taints" {
  type = list(object({
    effect = string
    key    = string
    value  = string
  }))
  default = [
    {
      effect = "NoSchedule"
      key    = "was"
      value  = "true"
    },
  ]
}