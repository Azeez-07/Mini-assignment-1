variable "instance_id" {
    description = "ID of the EC2 instance to monitor"
    type        = string
}

variable "cpu_threshold" {
    description = "CPU utilization threshold for the alarm"
    type        = number
    default     = 80
}