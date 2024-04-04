module "vpcs" {
  source = "./modules/vpc"

  vpc_configs = [
    {
      cidr_block = var.bastion_vpc_cidr
      name       = "Bastion_VPC"
    },
    {
      cidr_block = var.service_vpc_cidr
      name       = "Service_VPC"
    },
    {
      cidr_block = var.db_vpc_cidr
      name       = "DB_VPC"
    },
  ]
}