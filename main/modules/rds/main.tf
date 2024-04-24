resource "aws_db_instance" "rds" {
  identifier          = var.rds_name
  allocated_storage    = var.storage
  max_allocated_storage = var.max_storage
  engine               = var.engine_type
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.db_user_name
  password             = var.db_user_pass
  multi_az             = var.multi_az
  publicly_accessible  = var.publicly_accessible
  skip_final_snapshot   = var.skip_final_snapshot

  db_subnet_group_name = aws_db_subnet_group.default.id
  vpc_security_group_ids = var.db_sg_ids

  tags = {
      Name = var.rds_name
  }
}

resource "aws_db_subnet_group" "default" {
  name         = var.rds_subnet_group_name
  subnet_ids   = var.rds_subnet_ids

  tags = {
    Name = var.rds_subnet_group_name
  }
}