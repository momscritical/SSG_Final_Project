resource "aws_launch_template" "web" {
  name                   = "web"
  description            = "web EKS Node group launch template"
  image_id               = "ami-06a0d34318e968f30"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.project-key.key_name
  vpc_security_group_ids = [aws_security_group.web.id]
}

resource "aws_launch_template" "was" {
  name                   = "was"
  description            = "was EKS Node group launch template"
  image_id               = "ami-07e3124efa57d176a"
  instance_type          = "t3.medium"
  key_name               = aws_key_pair.project-key.key_name
  vpc_security_group_ids = [aws_security_group.was.id]
}

