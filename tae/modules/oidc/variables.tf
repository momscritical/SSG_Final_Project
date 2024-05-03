variable "cluster_name" {
  description = "Cluster Name Values for OIDC"
  type = string
  default = ""
}

variable "oidc" {
  description = "Cluster OIDC URL Values"
  type = string
  default = ""
}

# variable "thumbprint_list" {
#   description = "Thumbprint List Values"
#   type = string
#   default = ""
# }