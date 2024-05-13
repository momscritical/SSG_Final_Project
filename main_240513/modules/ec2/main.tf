resource "aws_instance" "bastion" {
  ami                          = var.bastion_ami
  instance_type                = var.bastion_instance_type
  vpc_security_group_ids       = var.bastion_sg_id
  key_name                     = var.bastion_key_name
  subnet_id                    = var.bastion_subnet_id
  associate_public_ip_address  = true
  user_data                    = var.bastion_user_data

  tags = {
    Name = var.bastion_name
  }
}

resource "aws_instance" "cp" {
  ami                          = var.cp_ami
  instance_type                = var.cp_instance_type
  vpc_security_group_ids       = var.cp_sg_id
  key_name                     = var.cp_key_name
  subnet_id                    = var.cp_subnet_id
  associate_public_ip_address  = true
  user_data                    = var.cp_user_data

  tags = {
    Name = var.cp_name
  }
}