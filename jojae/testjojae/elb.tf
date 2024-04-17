# Application Load Balancer 리소스 정의
resource "aws_lb" "web" {
  name               = "WebElb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnets[0].id, aws_subnet.public_subnets[1].id]
  security_groups    = [aws_security_group.alb-sg.id]
}

# Target Group 리소스 정의
resource "aws_lb_target_group" "asg_tg" {
  name        = "terraform-asg-tg"
  port        = 32706
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main-vpc.id
  target_type = "instance"

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5  # 5초의 타임아웃
    interval            = 30 # 30초 간격으로 헬스 체크
  }
}

# Load Balancer Listener 리소스 정의
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg_tg.arn
  }
}


resource "aws_lb" "was" {
  name               = "WasElb"
  load_balancer_type = "application"
  internal           = true
  subnets            = [aws_subnet.private_subnets[2].id, aws_subnet.private_subnets[3].id]

  security_groups = [aws_security_group.internal-alb-sg.id]
}


# Target Group 리소스 정의
resource "aws_lb_target_group" "internal_asg_tg" {
  name        = "terraform-internal-asg-tg"
  port        = 30441
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main-vpc.id
  target_type = "instance"

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5  # 5초의 타임아웃
    interval            = 30 # 30초 간격으로 헬스 체크
  }
}

# Load Balancer Listener 리소스 정의
resource "aws_lb_listener" "internal_alb_listener" {
  load_balancer_arn = aws_lb.was.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal_asg_tg.arn
  }
}
