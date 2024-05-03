resource "aws_security_group" "bastion" {
  name        = var.bastion_sg_name
  description = "Security Group for Bastion"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.bastion_ing_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.bastion_sg_name
  }
}

resource "aws_security_group" "web" { 
  name        = var.web_sg_name
  description = "Security Group for Web Layer Instance"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.web_ing_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = "tcp"
      security_groups = ingress.value.security_groups
    }
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.web_sg_name
  }
}

resource "aws_security_group" "set" {
  name        = var.set_sg_name
  description = "Security Group for was EKS Setting Node" 
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.set_ing_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = "tcp"
      security_groups = ingress.value.security_groups
    }
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.set_sg_name
  }
}

resource "aws_security_group" "was" { 
  name        = var.was_sg_name
  description = "Security Group for WAS Layer Instance"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.was_ing_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = "tcp"
      security_groups = ingress.value.security_groups
    }
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.was_sg_name
  }
}

resource "aws_security_group" "db" {
  name        = var.db_sg_name
  description = "Security Group for RDS DB" 
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.db_ing_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = "tcp"
      security_groups = ingress.value.security_groups
    }
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.db_sg_name
  }
}

resource "aws_security_group" "ext_lb" {
  name        = var.elb_sg_name
  description = "Security Group for External Load Balancer" 
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.elb_ing_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = "tcp"
    cidr_blocks   = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.elb_sg_name
  }
}

# resource "aws_security_group" "cluster" {
#   name        = var.cluster_sg_name
#   description = "Security Group for was EKS CLuster" 
#   vpc_id      = var.vpc_id

#   dynamic "ingress" {
#     for_each = var.cluster_ing_rules
#     content {
#       from_port       = ingress.value.from_port
#       to_port         = ingress.value.to_port
#       protocol        = "tcp"
#       security_groups = ingress.value.security_groups
#     }
#   }

#   egress {
#     from_port     = 0
#     to_port       = 0
#     protocol      = "-1"
#     cidr_blocks   = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = var.cluster_sg_name
#   }
# }

# resource "aws_security_group" "int_lb" {
#   name        = var.ilb_sg_name
#   description = "Security Group for Internal Load Balancer" 
#   vpc_id      = var.vpc_id

#   dynamic "ingress" {
#     for_each = var.ilb_ing_rules
#     content {
#       from_port       = ingress.value.from_port
#       to_port         = ingress.value.to_port
#       protocol        = "tcp"
#       security_groups = ingress.value.security_groups
#     }
#   }

#   egress {
#     from_port     = 0
#     to_port       = 0
#     protocol      = "-1"
#     cidr_blocks   = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = var.ilb_sg_name
#   }
# }

# resource "aws_security_group" "web_efs" {
#   name        = var.web_efs_sg_name
#   description = "Security Group for Web EFS" 
#   vpc_id      = var.vpc_id

#   dynamic "ingress" {
#     for_each = var.web_efs_ing_rules
#     content {
#       from_port       = ingress.value.from_port
#       to_port         = ingress.value.to_port
#       protocol        = "tcp"
#       security_groups = ingress.value.security_groups
#     }
#   }

#   egress {
#     from_port     = 0
#     to_port       = 0
#     protocol      = "-1"
#     cidr_blocks   = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = var.web_efs_sg_name
#   }
# }

# resource "aws_security_group" "was_efs" {
#   name        = var.was_efs_sg_name
#   description = "Security Group for was EFS" 
#   vpc_id      = var.vpc_id

#   dynamic "ingress" {
#     for_each = var.was_efs_ing_rules
#     content {
#       from_port       = ingress.value.from_port
#       to_port         = ingress.value.to_port
#       protocol        = "tcp"
#       security_groups = ingress.value.security_groups
#     }
#   }

#   egress {
#     from_port     = 0
#     to_port       = 0
#     protocol      = "-1"
#     cidr_blocks   = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = var.was_efs_sg_name
#   }
# }