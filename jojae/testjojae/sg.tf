resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Security Group for terraform bastion instance"
  vpc_id      = aws_vpc.main-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion-sg"
  }
}



resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Security Group for terraform alb"
  vpc_id      = aws_vpc.main-vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb-sg"
  }
}


resource "aws_security_group" "internal-alb-sg" {
  name        = "internal-alb-sg"
  description = "Security Group for terraform internal-alb"
  vpc_id      = aws_vpc.main-vpc.id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "internal-alb-sg"
  }
}

resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Security Group for terraform web"
  vpc_id      = aws_vpc.main-vpc.id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "web-sg"
  }
}

resource "aws_security_group" "was" {
  name        = "was-sg"
  description = "Security Group for terraform was"
  vpc_id      = aws_vpc.main-vpc.id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.internal-alb-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "was-sg"
  }
}


#resource "aws_security_group" "terrarform-rds-sg" {
#  name        = "terrarform-rds-sg"
#  description = "Security Group for terraform rds"
#  vpc_id      = aws_vpc.main-vpc.id
#  ingress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#  tags = {
#    Name = "rds-sg"
#  }
#}
