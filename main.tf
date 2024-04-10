terraform { 
  required_providers { 
    aws = { 
      source = "hashicorp/aws" 
      version = "~> 4.46.0" 
    } 
    random = { 
      source = "hashicorp/random" 
      version = "~> 3.4.3" 
    } 
    tls = { 
      source = "hashicorp/tls" 
      version = "~> 4.0.4" 
    } 
    cloudinit = { 
      source = "hashicorp/cloudinit" 
      version = "~> 2.2.0" 
    } 
    kubernetes = { 
      source = "hashicorp/kubernetes" 
      version = "~> 2.16.1" 
    } 
  } 
  required_version = "~> 1.3" 
}

provider "aws" { 
  region = var.region
}

module "final_vpc" {
  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}