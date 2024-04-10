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