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

module "final_sg" {
  source = "./modules/sg"

  vpc_id = module.vpc.vpc_id

  bastion_sg_name = var.bastion_sg_name
  web_sg_name = var.web_sg_name
  was_sg_name = var.was_sg_name
  db_sg_name = var.db_sg_name
  elb_sg_name = var.elb_sg_name
  ilb_sg_name = var.ilb_sg_name
  web_efs_sg_name = var.web_efs_sg_name
  was_efs_sg_name = var.was_efs_sg_name

  bastion_ing_ports = var.bastion_ing_ports
  web_ing_ports = var.web_ing_ports
  was_ing_ports = var.was_ing_ports
  db_ing_ports = var.db_ing_ports
  elb_ing_ports = var.elb_ing_ports
  ilb_ing_ports = var.ilb_ing_ports
  web_efs_ing_ports = var.web_efs_ing_ports
  was_efs_ing_ports = var.was_efs_ing_ports

  depends_on = [module.final_vpc]
}