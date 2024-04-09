resource "aws_eip" "nat_eip" {
  domain   = "vpc"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  
  tags = {
    Name = var.igw_name
 }
}
resource "aws_nat_gateway" "ngw" {
  allocation_id = var.nat_eip_id
  subnet_id     = var.subnet_id
  
  tags = {
    Name = var.ngw_name
 }
}