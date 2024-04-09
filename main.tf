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
  source = "./modules/network/vpc"

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}

module "final_subnet" {
  source = "./modules/network/subnet"

  vpc_id = module.final_vpc.vpc_id
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_name = var.public_subnet_name

  web_subnet_cidr = var.web_subnet_cidr
  web_subnet_name = var.web_subnet_name

  was_subnet_cidr = var.was_subnet_cidr
  was_subnet_name = var.was_subnet_name

  db_subnet_cidr = var.db_subnet_cidr
  db_subnet_name = var.db_subnet_name
  availability_zones = var.availability_zones
  depends_on = [module.final_vpc]
}

module "final_gateway" {
  source = "./modules/network/gateway"

  
}