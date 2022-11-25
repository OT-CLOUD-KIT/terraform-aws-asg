output "asg_lt_id" {
  value = aws_launch_template.lt.id
}

output "asg_lt_arn" {
  value = aws_launch_template.lt.arn
}

output "asg_id" {
  value = aws_autoscaling_group.asg.id
}

output "asg_arn" {
  value = aws_autoscaling_group.asg.arn
}