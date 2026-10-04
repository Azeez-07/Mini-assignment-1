output "vpc_id" {
  value = aws_vpc.azeez-vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public-subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private-subnet.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.my_igw.id
}