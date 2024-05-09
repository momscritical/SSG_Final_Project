output "bastion_sg_id" {
    value = aws_security_group.bastion.id
}

output "cp_sg_id" {
    value = aws_security_group.cp.id
}

output "app_sg_id" {
    value = aws_security_group.app.id
}

output "set_sg_id" {
    value = aws_security_group.set.id
}

output "db_sg_id" {
    value = aws_security_group.db.id
}

output "elb_sg_id" {
    value = aws_security_group.ext_lb.id
}