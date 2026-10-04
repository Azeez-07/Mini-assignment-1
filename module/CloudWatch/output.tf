output "cpu_utilization_alarm" {
  value = aws_cloudwatch_metric_alarm.cpu_utilization_alarm.alarm_name
}