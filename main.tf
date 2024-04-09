module "final_vpc" {
  source = "./modules/vpc/main.tf"

  cidr_block           = "10.0.0.0/16"
  vpc_name             = "project_VPC"
  enable_dns_hostnames = true
  enable_dns_support   = true
}
