output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_id" {
  description = "ID of the Public Subnet"
  value       = aws_subnet.public[count.index].id
}

output "web_subnet_id" {
  description = "ID of the Web Subnet"
  value       = aws_subnet.web[count.index].id
}

output "was_subnet_id" {
  description = "ID of the WAS Subnet"
  value       = aws_subnet.was[count.index].id
}

output "db_subnet_id" {
  description = "ID of the DataBase Subnet"
  value       = aws_subnet.db[count.index].id
}