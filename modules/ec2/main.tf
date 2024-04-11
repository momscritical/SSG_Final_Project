resource "aws_instance" "project_bastion" {
  ami               = var.ami
  instance_type     = var.instance_type
  vpc_security_group_ids = var.security_group_id
  key_name          = var.key_name
  subnet_id         = var.subnet_id
  associate_public_ip_address = true

  user_data = var.bastion_user_data

  tags = { 
    Name = var.bastion_name
  }
}