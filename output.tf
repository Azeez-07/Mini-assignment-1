output "server_1_elastic_ip" {
  value = module.elastic_ip.public_ip
}

output "server_1_instance_id" {
  value = module.server_1.id
}

output "server_2_elastic_ip" {
  value = module.elastic_ip.public_ip
}

output "server_2_instance_id" {
  value = module.server_2.id
}

output "server_3_elastic_ip" {
  value = module.elastic_ip.public_ip
}

output "server_3_instance_id" {
  value = module.server_3.id
}