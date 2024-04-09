resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id
  
  route {
    cidr_block = var.rt_cidr
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.public_rt_name}"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id
  
  route {
    cidr_block = var.rt_cidr
    nat_gateway_id = var.ngw_id
  }

  tags = {
    Name = "${var.private_rt_name}"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
  count = length(var.public_subnet_cidr)
  subnet_id      = element(var.public_subnet_id, count.index) 
  route_table_id = var.public_rt_id
}
resource "aws_route_table_association" "web_subnet_asso" {
  count = length(var.web_subnet_cidr) 
  subnet_id      = element(var.web_subnet_id, count.index) 
  route_table_id = var.private_rt_id
}
resource "aws_route_table_association" "app_subnet_asso" {
  count = length(var.was_subnet_cidr) 
  subnet_id      = element(var.was_subnet_id, count.index) 
  route_table_id = var.private_rt_id
}
resource "aws_route_table_association" "db_subnet_asso" {
  count = length(var.db_subnet_cidr) 
  subnet_id      = element(var.db_subnet_id, count.index) 
  route_table_id = var.private_rt_id
}

# resource "aws_subnet" "web" {
#   count              = length(var.web_subnet_cidr)
#   vpc_id             = var.vpc_id
#   cidr_block         = element(var.web_subnet_cidr, count.index)
#   availability_zone  = element(var.availability_zones, count.index)

#   tags = {
#     Name = "${var.web_subnet_name}-0${count.index + 1}"
#   }
# }