terraform { 
  required_providers { 
    aws = { 
      source  = "hashicorp/aws" 
      version = "~> 4.46.0" 
    } 
    random = { 
      source  = "hashicorp/random" 
      version = "~> 3.4.3" 
    } 
    tls = { 
      source  = "hashicorp/tls" 
      version = "~> 4.0.4" 
    } 
    cloudinit = { 
      source  = "hashicorp/cloudinit" 
      version = "~> 2.2.0" 
    } 
    kubernetes = { 
      source  = "hashicorp/kubernetes" 
      version = ">= 2.16.1" 
    } 
  } 
  required_version = "~> 1.3" 
}

provider "aws" { 
  region = var.region
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

# data "aws_eks_cluster" "test" {
#   name =var.cluster_name
# }
# data "aws_eks_cluster_auth" "test" {
#   name = var.cluster_name
# }
# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.test.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.test.certificate_authority[0].data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
#     command     = "aws"
#   }
# }