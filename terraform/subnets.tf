resource "aws_subnet" "secure_subnet" {
  vpc_id            = aws_vpc.secure_vpc.id
  cidr_block        = var.secure_subnet_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.secure_vpc_name}-pub_subnet"
  }
}

resource "aws_route_table" "secure_rt" {
  vpc_id = aws_vpc.secure_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.secure_vpc_igw.id
  }
  tags = {
    Name = "${var.secure_vpc_name}-rt"
  }
}


resource "aws_route_table_association" "secure_rt" {
  subnet_id      = aws_subnet.secure_subnet.id
  route_table_id = aws_route_table.secure_rt.id
}

