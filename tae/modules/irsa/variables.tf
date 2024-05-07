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
  type = list(string)
  default = []
}

variable "service_account_name" {
  description = "Name Values for EKS Service Account"
  type = list(string)
  default = ["system:serviceaccount:dev:s3-sa"]
}

variable "oidc_role_name" {
  description = "Cluster OIDC URL Values"
  type = string
  default = "SSG-Final-3-OIDC-S3-Role"
}