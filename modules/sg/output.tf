output "bastion_sg_id" {
    value = aws_security_group.bastion.id
}

output "web_sg_id" {
    value = aws_security_group.web.id
}

output "was_sg_id" {
    value = aws_security_group.was.id
}

output "db_sg_id" {
    value = aws_security_group.db.id
}

output "elb_sg_id" {
    value = aws_security_group.ext_lb.id
}

output "ilb_sg_id" {
    value = aws_security_group.int_lb.id
}

output "web_efs_sg_id" {
    value = aws_security_group.web_efs.id
}

output "was_efs_sg_id" {
    value = aws_security_group.was_efs.id
}

output "cluster_sg_id" {
    value = aws_security_group.cluster.id
}

output "control_plane_sg_id" {
    value = aws_security_group.control_plane.id
}