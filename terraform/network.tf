resource "aws_vpc" "secure_vpc" {
  cidr_block           = var.secure_vpc_cidr
  enable_dns_hostnames = "true"
  tags = {
    Name  = var.secure_vpc_name
    Owner = var.secure_vpc_owner
  }
}


resource "aws_internet_gateway" "secure_vpc_igw" {
  vpc_id = aws_vpc.secure_vpc.id
  tags = {
    Name = "${var.secure_vpc_name}-igw"
  }
}
