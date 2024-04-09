module "final_vpc" {
  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}

data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "./modules/vpc/terraform.tfstate"
  }
}

module "final_subnet" {
  source = "./modules/subnet"

  vpc_id = data.terraform_remote_state.vpc
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_name = var.public_subnet_name

  web_subnet_cidr = var.web_subnet_cidr
  web_subnet_name = var.web_subnet_name

  was_subnet_cidr = var.was_subnet_cidr
  was_subnet_name = var.was_subnet_name

  db_subnet_cidr = var.db_subnet_cidr
  db_subnet_name = var.db_subnet_name
  availability_zones = var.availability_zones
}