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
  region = var.region
}

module "final_vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  web_subnet_cidr     = var.web_subnet_cidr
  was_subnet_cidr     = var.was_subnet_cidr
  db_subnet_cidr      = var.db_subnet_cidr

  availability_zones  = var.availability_zones

  vpc_name            = var.vpc_name
  public_subnet_name  = var.public_subnet_name
  web_subnet_name     = var.web_subnet_name
  was_subnet_name     = var.was_subnet_name
  db_subnet_name      = var.db_subnet_name
  igw_name            = var.igw_name
  ngw_name            = var.ngw_name
  public_rt_name      = var.public_rt_name
  private_rt_name     = var.private_rt_name
}