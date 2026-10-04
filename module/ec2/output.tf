output "public_ip" {
  value = aws_instance.my_server.public_ip
}

output "id" {
  value = aws_instance.my_server.id
}