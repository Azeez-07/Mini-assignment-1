resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.azeez-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "public_route_table"
  }

}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.azeez-vpc.id

  tags = {
    Name = "private_route_table"
  }
}