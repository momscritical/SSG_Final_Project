# Web Instance ASG ####################################################
data "aws_autoscaling_groups" "web" {
  filter {
    name  = "tag:eks:nodegroup-name"
    values = [ var.web_asg_tag ]
  }
}

data "aws_autoscaling_group" "web" {
  name = data.aws_autoscaling_groups.web.names[0]
}

# 가져온 Autoscaling 그룹의 정보를 사용하여 ELB와 연결
resource "aws_autoscaling_attachment" "asg_attach" {
  autoscaling_group_name = data.aws_autoscaling_group.web.name
  lb_target_group_arn    = var.ext_lb_tg_arn
}

# WAS Instance ASG ####################################################
data "aws_autoscaling_groups" "was" {
  filter {
    name  = "tag:eks:nodegroup-name"
    values = [ var.was_asg_tag ]
  }
}

data "aws_autoscaling_group" "was" {
  name = data.aws_autoscaling_groups.was.names[0]
}

# 가져온 Autoscaling 그룹의 정보를 사용하여 ELB와 연결
resource "aws_autoscaling_attachment" "asg_was_attach" {
  autoscaling_group_name = data.aws_autoscaling_group.was.name
  lb_target_group_arn    = var.int_lb_tg_arn
}