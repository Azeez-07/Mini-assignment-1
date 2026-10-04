resource "aws_eip_association" "elasticIP_association" {
  instance_id   = var.instance_id
  allocation_id = aws_eip.ElasticIP.id
}