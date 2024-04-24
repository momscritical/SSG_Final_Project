resource "aws_instance" "project_bastion" {
  ami               = var.ami
  instance_type     = var.instance_type
  vpc_security_group_ids = var.bastion_sg_id
  key_name          = var.key_name
  subnet_id         = var.bastion_subnet_id
  associate_public_ip_address = true

  user_data = var.bastion_user_data

  tags = { 
    Name = var.bastion_name
  }
}

resource "aws_instance" "control_plane" {
  ami               = var.ami
  instance_type     = var.instance_type
  vpc_security_group_ids = var.control_plane_sg_id
  key_name          = var.key_name
  subnet_id         = var.control_plane_subnet_id
  associate_public_ip_address = false

  user_data = var.control_plane_user_data

  tags = { 
    Name = var.control_plane_name
  }
}