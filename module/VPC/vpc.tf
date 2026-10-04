resource "aws_vpc" "azeez-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "azeez-vpc"
  }
}