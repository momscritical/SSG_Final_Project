variable "cluster_name" {
  description = "Cluster Name Values for OIDC"
  type = string
  default = ""
}

variable "cluster_oidc_url" {
  description = "Cluster OIDC URL Values"
  type = string
  default = ""
}

variable "thumbprint_list" {
  description = "Thumbprint List Values"
  type = string
  default = ""
}