module "vpc" {
  source = "./module/vpc"
}

module "security_group" {
  source = "./module/Securitygroup"
  vpc_id = module.vpc.vpc_id
}

module "server_1" {
  source            = "./module/ec2"
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security_group.security_group_id
}

module "server_2" {
  source            = "./module/ec2"
  ami               = "ami-0b245cc5f82576748"
  instance_type     = "t3.small"
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security_group.security_group_id
  name              = "Project_Server_2"
}

module "server_3" {
  source            = "./module/ec2"
  ami               = "ami-0b5f627205de80196"
  instance_type     = "t3.micro"
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security_group.security_group_id
  name              = "Project_Server_3"
}

module "elastic_ip" {
  source      = "./module/ElasticIP"
  instance_id = module.server_1.id
}

module "cloudwatch" {
  source      = "./module/CloudWatch"
  instance_id = module.server_1.id
  cpu_threshold = 80
}