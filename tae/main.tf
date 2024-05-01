module "final_vpc" {
  source = "./modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  web_subnet_cidr     = ["10.0.11.0/24", "10.0.12.0/24"]
  was_subnet_cidr     = ["10.0.101.0/24", "10.0.102.0/24"]
  set_subnet_cidr      = ["10.0.103.0/24", "10.0.104.0/24"]
  db_subnet_cidr      = ["10.0.201.0/24", "10.0.202.0/24"]

  availability_zones  = ["ap-northeast-1a", "ap-northeast-1c"]

  vpc_name            = "Final-VPC"
  public_subnet_name  = "Bastion-Subnet"
  web_subnet_name     = "Web-Subnet"
  was_subnet_name     = "WAS-Subnet"
  set_subnet_name     = "Set-Subnet"
  db_subnet_name      = "DB-Subnet"
  igw_name            = "Internet-Gateway"
  ngw_name            = "NAT-Gateway"
  public_rt_name      = "Public-Routing-Table"
  private_rt_name     = "Private-Routing-Table"
}

module "final_sg" {
  source = "./modules/sg"

  vpc_id = module.final_vpc.vpc_id

  bastion_sg_name = "Public-SG"
  web_sg_name = "Web-SG"
  was_sg_name = "WAS-SG"
  set_sg_name = "Set-SG"
  db_sg_name = "DataBase-SG"
  elb_sg_name = "Ext-LB-SG"
  ilb_sg_name = "Int-LB-SG"

  bastion_ing_rules = [
    {
      from_port = 22
      to_port   = 22
    }
  ]

  web_ing_rules = [
    {
      from_port       = 22
      to_port         = 22
      security_groups = [module.final_sg.bastion_sg_id]
    },
    {
      from_port       = 80
      to_port         = 80
      security_groups = [module.final_sg.elb_sg_id]
    }
  ]

  was_ing_rules = [
    {
      from_port       = 22
      to_port         = 22
      security_groups = [module.final_sg.bastion_sg_id]
    },
    {
      from_port       = 80
      to_port         = 80
      security_groups = [module.final_sg.web_sg_id]
    }
  ]

  set_ing_rules = [
    {
      from_port       = 22
      to_port         = 22
      security_groups = [module.final_sg.bastion_sg_id]
    }
  ]

  db_ing_rules = [
    {
      from_port       = 3306
      to_port         = 3306
      security_groups = [module.final_sg.web_sg_id]
    },
    {
      from_port       = 3306
      to_port         = 3306
      security_groups = [module.final_sg.was_sg_id]
    }
  ]

  elb_ing_rules = [
    {
      from_port = 80
      to_port   = 80
    }
  ]

  depends_on = [module.final_vpc]
}

module "final_key" {
  source = "./modules/key_pair"
  key_name = "final-key"
  public_key_location = "~/.ssh/final-key.pub"
  key_tags = "Final-Key"
}

module "final_bastion" {
  source = "./modules/ec2"
  
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.small"
  key_name               = module.final_key.key_name
  bastion_sg_id          = [module.final_sg.bastion_sg_id]
  bastion_subnet_id      = module.final_vpc.public_subnet_id[0]
  bastion_user_data      = templatefile("./user_data_file/user_data_bastion.sh", {})
  bastion_name           = "Bastion"
}

module "final_eks" {
  source = "./modules/eks"

  cluster_role_name      = "SSG-2-EKS-Cluster-Role"
  cluster_name           = "EKS-Cluster"
  node_group_role_name   = "SSG-2-EKS-NodeGroup-Role"
  web_node_group_name    = "Web-Node"
  was_node_group_name    = "WAS-Node"
  set_node_group_name    = "Set-Node"

  yaml_dir               = "./yaml"
  region                 = "ap-northeast-1"
  k8s_version            = "1.29"

  cluster_subnet_ids     = module.final_vpc.eks_subnet_ids
  web_node_group_subnet_ids = module.final_vpc.web_subnet_id
  was_node_group_subnet_ids = module.final_vpc.was_subnet_id
  set_node_group_subnet_ids = module.final_vpc.set_subnet_id

  web_instance_types     = ["t2.small"]
  was_instance_types     = ["t2.small"]
  set_instance_types     = ["t2.small"]

  web_node_group_desired_size = 2
  web_node_group_max_size     = 3
  web_node_group_min_size     = 1
  was_node_group_desired_size = 2
  was_node_group_max_size     = 3
  was_node_group_min_size     = 1
  set_node_group_desired_size = 2
  set_node_group_max_size     = 3
  set_node_group_min_size     = 1

  web_max_unavailable   = 1
  was_max_unavailable   = 1
  set_max_unavailable   = 1

  web_taint_key    = "web"
  web_taint_value  = "true"
  web_taint_effect = "NO_SCHEDULE"
  was_taint_key    = "was"
  was_taint_value  = "true"
  was_taint_effect = "NO_SCHEDULE"

  web_environment = "production"
  web_asg_tag     = "Web-Node"
  was_environment = "production"
  was_asg_tag     = "WAS-Node"
}

module "final_rds" {
  source = "./modules/rds"

  rds_name               = "final-rds"
  storage                = 50
  max_storage            = 100
  engine_type            = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.m5d.large"
  db_name                = "coupang"
  db_user_name           = "root"
  db_user_pass           = "admin12345"
  multi_az               = true
  publicly_accessible    = false
  skip_final_snapshot    = true

  db_sg_ids              = [module.final_sg.db_sg_id]
  
  rds_subnet_group_name  = "rds-subnet-group"
  rds_subnet_ids         = module.final_vpc.db_subnet_id
}

module "final_ingress_controller" {
  source        = "./modules/ingress"
  yaml_location = "./yaml/ingress-controller.yaml"
  depends_on    = [module.final_eks]
}

locals {
  oidc            = module.final_eks.oidc
  split_oidc      = split("/", local.oidc)
  url             = element(local.split_oidc, 2)
  thumbprint_list = element(local.split_oidc, 4)
}

module "final_oidc" {
  source = "./modules/oidc"
  cluster_name = "EKS-Cluster"
  cluster_oidc_url = local.url
  thumbprint_list = local.thumbprint_list
}


# module "final_lb" {
#   source = "./modules/lb"

#   vpc_id = module.final_vpc.vpc_id
#   public_subnet_id = module.final_vpc.public_subnet_id
#   web_subnet_id = module.final_vpc.web_subnet_id

#   ext_lb_name = "Ext-LB"
#   ext_tg_name = "Ext-TG"
#   # int_lb_name = "Int-LB"
#   # int_tg_name = "Int-TG"

#   ext_lb_type = "application"
#   # int_lb_type = "application"
#   ext_default_action_type = "forward"
#   # int_default_action_type = "forward"

#   ext_sg_id = [ module.final_sg.elb_sg_id ]
#   # int_sg_id = [ module.final_sg.ilb_sg_id ]

#   ext_listener_port = "80"
#   ext_listener_protocol = "HTTP"
#   ext_tg_port = "32706"
#   ext_tg_protocol = "HTTP"

#   # int_listener_port = "80"
#   # int_listener_protocol = "HTTP"
#   # int_tg_port = "30441"
#   # int_tg_protocol = "HTTP"

#   ext_listener_tg_type = "instance"
#   # int_listener_tg_type = "instance"

#   ext_hc_matcher = "200,301,302"
#   ext_hc_path = "/"
#   ext_hc_healthy_threshold = 2
#   ext_hc_unhealthy_threshold = 2
#   ext_hc_timeout = 5
#   ext_hc_interval = 30

#   # int_hc_matcher = "200,301,302"
#   # int_hc_path = "/"
#   # int_hc_healthy_threshold = 2
#   # int_hc_unhealthy_threshold = 2
#   # int_hc_timeout = 5
#   # int_hc_interval = 30
# }

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