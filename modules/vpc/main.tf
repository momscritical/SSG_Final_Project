resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = { 
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count              = length(var.public_subnet_cidr)
  vpc_id             = aws_vpc.vpc.id
  cidr_block         = element(var.public_subnet_cidr, count.index)
  availability_zone  = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.public_subnet_name}-0${count.index + 1}"
  }
}

resource "aws_subnet" "web" {
  count              = length(var.web_subnet_cidr)
  vpc_id             = aws_vpc.vpc.id
  cidr_block         = element(var.web_subnet_cidr, count.index)
  availability_zone  = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.web_subnet_name}-0${count.index + 1}"
  }
}

resource "aws_subnet" "was" {
  count              = length(var.was_subnet_cidr)
  vpc_id             = aws_vpc.vpc.id
  cidr_block         = element(var.was_subnet_cidr, count.index)
  availability_zone  = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.was_subnet_name}-0${count.index + 1}"
  }
}

resource "aws_subnet" "db" {
  count              = length(var.db_subnet_cidr)
  vpc_id             = aws_vpc.vpc.id
  cidr_block         = element(var.db_subnet_cidr, count.index)
  availability_zone  = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.db_subnet_name}-0${count.index + 1}"
  }
}

resource "aws_eip" "nat_eip" {
  domain   = "vpc"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = var.igw_name
 }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = var.ngw_name
 }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.public_rt_name}"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "${var.private_rt_name}"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
  count = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public[*].id, count.index) 
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "web_subnet_asso" {
  count = length(var.web_subnet_cidr)
  subnet_id      = element(aws_subnet.web[*].id, count.index) 
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "app_subnet_asso" {
  count = length(var.was_subnet_cidr) 
  subnet_id      = element(aws_subnet.was[*].id, count.index) 
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "db_subnet_asso" {
  count = length(var.db_subnet_cidr) 
  subnet_id      = element(aws_subnet.db[*].id, count.index) 
  route_table_id = aws_route_table.private_rt.id
}