resource "aws_instance" "project_bastion" {
  ami                          = var.ami
  instance_type                = var.instance_type
  vpc_security_group_ids       = var.bastion_sg_id
  key_name                     = var.key_name
  subnet_id                    = var.bastion_subnet_id
  associate_public_ip_address  = true
  user_data                    = var.bastion_user_data

  tags = {
    Name = var.bastion_name
  }
}