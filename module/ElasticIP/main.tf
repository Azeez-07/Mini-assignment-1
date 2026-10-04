resource "aws_eip" "ElasticIP" {
  domain = "vpc"

  tags = {
    Name = "azeez_elasticIP"
  }
}