output "bastion_sg_id" {
    value = aws_security_group.bastion.id
}

output "web_sg_id" {
    value = aws_security_group.web.id
}

output "was_sg_id" {
    value = aws_security_group.was.id
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

# output "cluster_sg_id" {
#     value = aws_security_group.cluster.id
# }

# output "ilb_sg_id" {
#     value = aws_security_group.int_lb.id
# }

# output "control_plane_sg_id" {
#     value = aws_security_group.control_plane.id
# }