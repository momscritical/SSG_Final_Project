resource "aws_security_group" "bastion-sg" {
  name        = "terrarform-bastion-sg"
  description = "Security Group for terraform bastion instance"
  vpc_id      = aws_vpc.main-vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terrarform-bastion-sg"
  }
}



resource "aws_security_group" "alb-sg" {
  name        = "terrarform-alb-sg"
  description = "Security Group for terraform alb"
  vpc_id      = aws_vpc.main-vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terrarform-alb-sg"
  }
}


resource "aws_security_group" "internal-alb-sg" {
  name        = "terrarform-internal-alb-sg"
  description = "Security Group for terraform internal-alb"
  vpc_id      = aws_vpc.main-vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terrarform-internal-alb-sg"
  }
}


#resource "aws_security_group" "terrarform-rds-sg" {
#  name        = "terrarform-rds-sg"
#  description = "Security Group for terraform rds"
#  vpc_id      = aws_vpc.main-vpc.id
#  ingress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#  tags = {
#    Name = "terrarform-rds-sg"
#  }
#}
