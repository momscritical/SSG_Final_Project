resource "aws_vpc" "vpcs" {
  count = length(var.vpc_configs)

  cidr_block = var.vpc_configs[count.index].cidr_block

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = { 
    Name = var.vpc_configs[count.index].name
  }
}