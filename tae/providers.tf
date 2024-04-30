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
      version = "~> 2.16.1" 
    } 
  } 
  required_version = "~> 1.3" 
}

provider "aws" { 
  region = "ap-northeast-1"
}

# provider "kubernetes" {
#   host                   = module.final_eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.final_eks.kubeconfig-certificate-authority-data)
# }

# provider "kubernetes" {
#   host                   = module.final_eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.final_eks.kubeconfig-certificate-authority-data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", "EKS-Cluster"]
#     command     = "aws"
#   }
# }

# provider "kubernetes" {
#   config_path    = "~/.kube/config"  # 또는 다른 kubeconfig 파일 경로
#   config_context = module.final_eks.eks_cluster_config_context  # kubeconfig에서 설정한 context 이름

#   exec {
#     api_version = "client.authentication.k8s.io/v1alpha1"
#     command     = "aws-iam-authenticator"
#     args        = ["token", "-i", "EKS-Cluster"]
#   }
# }