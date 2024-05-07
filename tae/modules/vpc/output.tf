output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_id" {
  description = "ID of the Public Subnet"
  value       = aws_subnet.public[*].id
}

output "cp_subnet_id" {
  description = "ID of the Control Plane Subnet"
  value       = aws_subnet.cp[*].id
}

output "app_subnet_id" {
  description = "ID of the Web Subnet"
  value       = aws_subnet.app[*].id
}

# output "was_subnet_id" {
#   description = "ID of the WAS Subnet"
#   value       = aws_subnet.was[*].id
# }

output "set_subnet_id" {
  description = "ID of the Setting Node Subnet"
  value       = aws_subnet.set[*].id
}

output "db_subnet_id" {
  description = "ID of the DataBase Subnet"
  value       = aws_subnet.db[*].id
}

output "eks_subnet_ids" {
  description = "Combined list of Web and WAS Subnet IDs"
  value       = concat(aws_subnet.web[*].id, aws_subnet.was[*].id, aws_subnet.set[*].id)
}