module "final_vpc" {
  source = "./modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  web_subnet_cidr     = ["10.0.11.0/24", "10.0.12.0/24"]
  was_subnet_cidr     = ["10.0.101.0/24", "10.0.102.0/24"]
  db_subnet_cidr      = ["10.0.201.0/24", "10.0.202.0/24"]

  availability_zones  = ["ap-northeast-1a", "ap-northeast-1c"]

  vpc_name            = "Final-VPC"
  public_subnet_name  = "Bastion-Subnet"
  web_subnet_name     = "Web-Subnet"
  was_subnet_name     = "WAS-Subnet"
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
  db_sg_name = "DataBase-SG"
  elb_sg_name = "Ext-LB-SG"
  ilb_sg_name = "Int-LB-SG"
  web_efs_sg_name = "Web-EFS-SG"
  was_efs_sg_name = "WAS-EFS-SG"

  bastion_ing_rules = [
    {
      from_port = 22
      to_port   = 22
    },
    {
      from_port = 3000
      to_port   = 3000
    },
    {
      from_port = 9090
      to_port   = 9090
    }
  ]

  web_ing_rules = [
    {
      from_port       = 22
      to_port         = 22
      security_groups = [module.final_sg.bastion_sg_id]
    },
    {
      from_port       = 5000
      to_port         = 5000
      security_groups = [module.final_sg.elb_sg_id]
    },
    {
      from_port       = 9100
      to_port         = 9100
      security_groups = [module.final_sg.bastion_sg_id]
    }
  ]

  was_ing_rules = [
    {
      from_port       = 22
      to_port         = 22
      security_groups = [module.final_sg.bastion_sg_id]
    },
    {
      from_port       = 5000
      to_port         = 5000
      security_groups = [module.final_sg.ilb_sg_id]
    },
    {
      from_port       = 9100
      to_port         = 9100
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

  ilb_ing_rules = [
    {
      from_port       = 5000
      to_port         = 5000
      security_groups = [module.final_sg.web_sg_id]
    }
  ]

  web_efs_ing_rules = [
    {
      from_port       = 2049
      to_port         = 2049
      security_groups = [module.final_sg.web_sg_id]
    }
  ]

  was_efs_ing_rules = [
    {
      from_port       = 2049
      to_port         = 2049
      security_groups = [module.final_sg.was_sg_id]
    }
  ]

  depends_on = [module.final_vpc]
}