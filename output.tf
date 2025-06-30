output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.name
}

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.this.id
}

output "scale_up_alarm_name" {
  value       = try(aws_cloudwatch_metric_alarm.scale_up_alarm[0].alarm_name, null)
  description = "CloudWatch Alarm for scale-up"
}

output "scale_down_alarm_name" {
  value       = try(aws_cloudwatch_metric_alarm.scale_down_alarm[0].alarm_name, null)
  description = "CloudWatch Alarm for scale-down"
}
