resource "aws_subnet" "public" {
  count              = length(var.public_subnet_cidr)
  vpc_id             = var.vpc_id
  cidr_block         = element(var.public_subnet_cidr, count.index)
  availability_zone  = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.public_subnet_name}-0${count.index + 1}"
  }
}

resource "aws_subnet" "web" {
  count              = length(var.web_subnet_cidr)
  vpc_id             = var.vpc_id
  cidr_block         = element(var.web_subnet_cidr, count.index)
  availability_zone  = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.web_subnet_name}-0${count.index + 1}"
  }
}

resource "aws_subnet" "was" {
  count              = length(var.was_subnet_cidr)
  vpc_id             = var.vpc_id
  cidr_block         = element(var.was_subnet_cidr, count.index)
  availability_zone  = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.was_subnet_name}-0${count.index + 1}"
  }
}

resource "aws_subnet" "db" {
  count              = length(var.db_subnet_cidr)
  vpc_id             = var.vpc_id
  cidr_block         = element(var.db_subnet_cidr, count.index)
  availability_zone  = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.db_subnet_name}-0${count.index + 1}"
  }
}