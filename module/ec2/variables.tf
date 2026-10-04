variable "ami" {
  description = "This is server image"
  type        = string
  default     = "ami-0f8a61b66d1accaee"
}

variable "instance_type" {
  description = "Type of instance"
  type        = string
  default     = "t3.micro"
}

variable "name" {
  description = "Server name"
  type        = string
  default     = "Project_Server"
}

variable "key_name" {
  description = "ssh key for the instance"
  type        = string
  default     = "Testserver"
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}