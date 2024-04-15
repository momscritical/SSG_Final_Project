# Web Instance ASG ####################################################
resource "aws_autoscaling_group" "web" {
  name = var.web_asg_name
  min_size             = var.web_min_size
  desired_capacity     = var.web_desired_capacity
  max_size             = var.web_max_size
  target_group_arns = var.ext_tg_arns

  health_check_type    = "EC2"
#  launch_configuration = aws_launch_configuration.web.name
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  vpc_zone_identifier  = var.web_subnet_id

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key = "Name"
    value = var.web_asg_name
    propagate_at_launch = true
    }
}

# WAS Instance ASG ####################################################
resource "aws_autoscaling_group" "was" {
  name = var.was_asg_name
  min_size             = var.was_min_size
  desired_capacity     = var.was_desired_capacity
  max_size             = var.was_max_size
  target_group_arns = var.int_tg_arns

  health_check_type    = "EC2"
#  launch_configuration = aws_launch_configuration.app.name
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  vpc_zone_identifier  = var.web_subnet_id

  lifecycle {
    create_before_destroy = true
  }
  
  tag {
    key ="Name"
    value = var.was_asg_name
    propagate_at_launch = true
    }
}
