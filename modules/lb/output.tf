output "ext_tg_arns" {
    description = "value"
    value = aws_lb_target_group.ext.arn
}

output "int_tg_arns" {
    description = "value"
    value = aws_lb_target_group.int.arn
}