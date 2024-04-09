output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_id" {
  value = aws_vpc.default.id
}

output "public_subnet_ids" {
  value = [
    module.public_subnet.subnet_id,
  ]
}

output "private_subnet_ids" {
  value = [
    module.private_subnet_1.subnet_id,
    module.private_subnet_2.subnet_id,
    module.private_subnet_3.subnet_id,
  ]
}