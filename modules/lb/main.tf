# External Load Balancer ####################################################
resource "aws_lb" "ext" {
  name               = var.ext_lb_name
  load_balancer_type = "application"
  internal = false
  subnets = var.public_subnet_id
  security_groups = var.ext_sg_id

  tags = {
    Name = var.ext_lb_name
  }
}

resource "aws_lb_listener" "ext" {
  load_balancer_arn = aws_alb.ext.arn
  port              = var.ext_listener_port
  protocol          = var.ext_listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ext.arn
  }
}

resource "aws_lb_target_group" "ext" {
  name        = var.ext_tg_name
  port        = var.ext_tg_port
  protocol    = var.ext_tg_protocol
  vpc_id      = var.vpc_id
  health_check {
    matcher = "200,301,302"
    path = "/"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout             = 5   # 5초의 타임아웃
    interval            = 30  # 30초 간격으로 헬스 체크
  }
}

# Internal Load Balancer ####################################################
resource "aws_lb" "int" {
  name               = var.int_lb_name
  internal           = true
  load_balancer_type = "application"
  subnets = var.web_subnet_id
  security_groups = var.int_sg_id

  tags = {
    Name = var.int_lb_name
  }
}

resource "aws_lb_listener" "int" {
  load_balancer_arn = aws_alb.internal_lb.arn
  port              = var.int_listener_port
  protocol          = var.int_listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.int.arn
  }
}

resource "aws_lb_target_group" "int" {
  name        = var.int_tg_name
  port        = var.int_tg_port
  protocol    = var.int_tg_protocol
  # target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    matcher = "200,301,302"
    path = "/"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout             = 5   # 5초의 타임아웃
    interval            = 30  # 30초 간격으로 헬스 체크
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