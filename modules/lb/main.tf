# External Load Balancer ####################################################
resource "aws_lb" "ext" {
    name               = var.ext_lb_name
    load_balancer_type = var.ext_lb_type
    internal           = false
    subnets            = var.public_subnet_id
    security_groups    = var.ext_sg_id

    tags = {
        Name = var.ext_lb_name
    }
}

resource "aws_lb_listener" "ext" {
    load_balancer_arn = aws_lb.ext.arn
    port              = var.ext_listener_port
    protocol          = var.ext_listener_protocol

    default_action {
        type             = var.ext_default_action_type
        target_group_arn = aws_lb_target_group.ext.arn
    }
}

resource "aws_lb_target_group" "ext" {
    name        = var.ext_tg_name
    port        = var.ext_tg_port
    protocol    = var.ext_tg_protocol
    target_type = var.ext_tg_type
    vpc_id      = var.vpc_id

    health_check {
        matcher            = var.ext_hc_matcher
        path               = var.ext_hc_path
        healthy_threshold  = var.ext_hc_healthy_threshold
        unhealthy_threshold = var.ext_hc_unhealthy_threshold
        timeout            = var.ext_hc_timeout
        interval           = var.ext_hc_interval
    }
}

# Internal Load Balancer ####################################################
resource "aws_lb" "int" {
    name               = var.int_lb_name
    internal           = true
    load_balancer_type = var.int_lb_type
    subnets            = var.web_subnet_id
    security_groups    = var.int_sg_id

    tags = {
        Name = var.int_lb_name
    }
}

resource "aws_lb_listener" "int" {
    load_balancer_arn = aws_lb.int.arn
    port              = var.int_listener_port
    protocol          = var.int_listener_protocol

    default_action {
        type             = var.int_default_action_type
        target_group_arn = aws_lb_target_group.int.arn
    }
}

resource "aws_lb_target_group" "int" {
    name        = var.int_tg_name
    port        = var.int_tg_port
    protocol    = var.int_tg_protocol
    target_type = var.int_tg_type
    vpc_id      = var.vpc_id

    health_check {
        matcher            = var.int_hc_matcher
        path               = var.int_hc_path
        healthy_threshold  = var.int_hc_healthy_threshold
        unhealthy_threshold = var.int_hc_unhealthy_threshold
        timeout            = var.int_hc_timeout
        interval           = var.int_hc_interval
    }
}


# resource "aws_lb_target_group_attachment" "ext" {
#     target_group_arn = aws_lb_target_group.ext-tg.arn
#     target_id = aws_instance.project_web.id
#     port = 5000
# }

# resource "aws_lb_target_group_attachment" "int" {
#     target_group_arn = aws_lb_target_group.int-tg.arn
#     target_id = aws_instance.project_app.id
#     port = 5000
# }