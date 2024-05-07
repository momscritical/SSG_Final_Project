module "final_vpc" {
  source = "./modules/vpc"

  availability_zones  = var.availability_zones

  vpc_cidr            = var.vpc_config.cidr
  public_subnet_cidr  = var.public_subnet_config.cidr
  cp_subnet_cidr      = var.cp_subnet_config.cidr
  app_subnet_cidr     = var.app_subnet_config.cidr
  set_subnet_cidr     = var.set_subnet_config.cidr
  db_subnet_cidr      = var.db_subnet_config.cidr

  vpc_name            = var.vpc_config.name
  public_subnet_name  = var.public_subnet_config.name
  cp_subnet_name      = var.public_subnet_config.name
  app_subnet_name     = var.app_subnet_config.name
  set_subnet_name     = var.set_subnet_config.name
  db_subnet_name      = var.db_subnet_config.name
  igw_name            = var.igw_name
  ngw_name            = var.ngw_name
  public_rt_name      = var.public_rt_name
  private_rt_name     = var.private_rt_name

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
}

module "final_sg" {
  source = "./modules/sg"

  vpc_id          = module.final_vpc.vpc_id

  bastion_sg_name = var.bastion_sg_config.name
  cp_sg_name      = var.cp_sg_config.name
  app_sg_name     = var.app_sg_config.name
  set_sg_name     = var.set_sg_config.name
  db_sg_name      = var.db_sg_config.name
  elb_sg_name     = var.elb_sg_config.name

  bastion_ing_rules = [
    {
      from_port       = var.bastion_sg_config.ing_port[0]
      to_port         = var.bastion_sg_config.ing_port[0]
    }
  ]

  cp_ing_rules = [
    {
      from_port       = var.cp_sg_config.ing_port[0]
      to_port         = var.cp_sg_config.ing_port[0]
      security_groups = [ module.final_sg.bastion_sg_id ]
    }
  ]
  
  app_ing_rules = [
    {
      from_port       = var.app_sg_config.ing_port[0]
      to_port         = var.app_sg_config.ing_port[0]
      security_groups = [ module.final_sg.bastion_sg_id ]
    },
    {
      from_port       = var.app_sg_config.ing_port[1]
      to_port         = var.app_sg_config.ing_port[1]
      security_groups = [ module.final_sg.elb_sg_id ]
    }
  ]

  set_ing_rules = [
    {
      from_port       = var.set_sg_config.ing_port[0]
      to_port         = var.set_sg_config.ing_port[0]
      security_groups = [ module.final_sg.bastion_sg_id ]
    }
  ]

  db_ing_rules = [
    {
      from_port       = var.db_sg_config.ing_port[0]
      to_port         = var.db_sg_config.ing_port[0]
      security_groups = [ module.final_sg.app_sg_id ]
    }
  ]

  elb_ing_rules = [
    {
      from_port      = var.elb_sg_config.ing_port[0]
      to_port        = var.elb_sg_config.ing_port[0]
    }
  ]

  depends_on = [module.final_vpc]
}

module "final_key" {
  source              = "./modules/key_pair"

  key_name            = var.key_config.name
  public_key_location = var.key_config.public_key_location
  key_tags            = var.key_config.tags
}

module "final_ec2" {
  source = "./modules/ec2"
  
  bastion_ami           = data.aws_ami.amazon_linux_2023.id
  bastion_instance_type = var.bastion_config.instance_types
  bastion_key_name      = module.final_key.key_name
  bastion_sg_id         = [module.final_sg.bastion_sg_id]
  bastion_subnet_id     = module.final_vpc.public_subnet_id[0]
  bastion_name          = var.bastion_config.name
  bastion_user_data     = templatefile(var.bastion_config.user_data, {})

  cp_ami                = data.aws_ami.amazon_linux_2023.id
  cp_instance_type      = var.cp_config.instance_types
  cp_key_name           = module.final_key.key_name
  cp_sg_id              = [module.final_sg.cp_sg_id]
  cp_subnet_id          = module.final_vpc.cp_subnet_id[0]
  cp_name               = var.cp_config.name
  cp_user_data          = templatefile(var.cp_config.user_data, {}) 
}

module "final_eks" {
  source = "./modules/eks"

  cluster_role_name            = var.cluster_role_name
  cluster_name                 = var.cluster_name

  node_group_role_name         = var.node_group_role_name
  app_node_group_name          = var.app_node_config.name
  set_node_group_name          = var.set_node_config.name

  k8s_version                  = var.k8s_version
  region                       = var.region

  cluster_subnet_ids           = module.final_vpc.eks_subnet_ids
  app_node_group_subnet_ids    = module.final_vpc.app_subnet_id
  set_node_group_subnet_ids    = module.final_vpc.set_subnet_id

  app_instance_types           = [var.app_node_config.instance_types]
  set_instance_types           = [var.set_node_config.instance_types]

  app_node_group_desired_size = var.app_node_config.desired_size
  app_node_group_max_size     = var.app_node_config.max_size
  app_node_group_min_size     = var.app_node_config.min_size
  set_node_group_desired_size = var.set_node_config.desired_size
  set_node_group_max_size     = var.set_node_config.max_size
  set_node_group_min_size     = var.set_node_config.min_size

  app_max_unavailable         = var.app_node_config.max_unavailable
  set_max_unavailable         = var.set_node_config.max_unavailable

  app_taint_key               = var.app_node_config.taint_key
  app_taint_value             = var.app_node_config.taint_value
  app_taint_effect            = var.app_node_config.taint_effect

  app_environment             = var.app_node_config.environment
  app_asg_tag                 = var.app_node_config.asg_tag
}

module "final_ingress_controller" {
  source        = "./modules/ingress_controller"

  yaml_location = var.ingress_controller_yaml
  depends_on    = [ module.final_eks ]
}

module "final_irsa" {
  source = "./modules/irsa"

  cluster_name = var.cluster_name

  cluster_oidc_url= module.final_eks.cluster_issuer

  service_account_name = var.service_account_name
  oidc_role_name = var.oidc_role_name

  depends_on = [ module.final_eks ]
}

module "final_rds" {
  source = "./modules/rds"

  rds_name               = var.rds_config.name
  storage                = var.rds_config.storage
  max_storage            = var.rds_config.max_storage
  engine_type            = var.rds_config.engine_type
  engine_version         = var.rds_config.engine_version
  instance_class         = var.rds_config.instance_class
  db_name                = var.rds_config.db_name
  db_user_name           = var.rds_config.db_user_name
  db_user_pass           = var.rds_config.db_user_pass
  multi_az               = var.rds_config.multi_az
  publicly_accessible    = var.rds_config.publicly_accessible
  skip_final_snapshot    = var.rds_config.skip_final_snapshot

  db_sg_ids              = [module.final_sg.db_sg_id]
  
  rds_subnet_group_name  = var.rds_config.rds_subnet_group_name
  rds_subnet_ids         = module.final_vpc.db_subnet_id
}

# ???
# module "final_asg" {
#   source = "./modules/asg"

#   web_asg_name = module.final_eks.web_asg_name
#   was_asg_name = module.final_eks.was_asg_name
#   web_asg_tag = module.final_eks.web_asg_tag
#   was_asg_tag = module.final_eks.was_asg_tag
#   # ext_lb_tg_arn = module.final_lb.ext_tg_arns
#   # int_lb_tg_arn = module.final_lb.int_tg_arns

#   depends_on = [
#     module.final_eks,
#     # module.final_lb
#   ]
# }