resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = { 
    Name = var.vpc_name
  }

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
}