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

module "final_key" {
  source = "./modules/key_pair"
  key_name = "final-key"
  public_key_location = "~/.ssh/final-key.pub"
  key_tags = "Final-Key"
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "final_bastion_control_plane" {
  source = "./modules/ec2"
  
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.small"
  key_name               = module.final_key.key_name
  bastion_sg_id          = module.final_sg.bastion_sg_id
  bastion_subnet_id      = module.final_vpc.public_subnet_id[0]
  bastion_user_data      = templatefile("./user_data_file/user_data_bastion.sh", {})
  bastion_name           = "Bastion"
  control_plane_sg_id    = module.final_sg.control_plane_sg_id
  control_plane_subnet_id = module.final_vpc.was_subnet_id[0]
  control_plane_user_data = templatefile("./user_data_file/user_data_control.sh", {})
  control_plane_name     = "EKS-Controll-Plane"
}

module "final_eks" {
  source                 = "./modules/eks"
  cluster_role_name      = "EKS-Cluster-Role"
  cluster_name           = "EKS-Cluster"
  node_group_role_name   = "SSG-1-EKS-NodeGroup-Role"
  web_node_group_name    = "Web-Node"
  was_node_group_name    = "WAS-Node"

  cluster_subnet_ids     = module.final_vpc.web_was_subnet_ids
  web_node_group_subnet_ids = module.final_vpc.web_subnet_id
  was_node_group_subnet_ids = module.final_vpc.was_subnet_id

  web_node_group_desired_size = 2
  web_node_group_max_size = 3
  web_node_group_min_size = 1
  was_node_group_desired_size = 2
  was_node_group_max_size = 3
  was_node_group_min_size = 1
  
  web_max_unavailable   = 1
  was_max_unavailable   = 1
}