output "launch_template" {
  value = aws_launch_template.Application.id
  description = "Launch Template Id"
}
output "ASG_group_id" {
  value = aws_autoscaling_group.Application.id
  description = "Auto scaling group Id"
}

output "ASG_group_arn" {
  value = aws_autoscaling_group.Application.arn
  description = "Auto scaling group arn"
}

output "aws_autoscaling_policy_scale_up" {
  value = aws_autoscaling_policy.scale_up.id
  description = "Auto scaling scale up policy"
}

output "aws_autoscaling_policy_scale_down" {
  value = aws_autoscaling_policy.scale_down.id
   description = "Auto scaling scale down policy"
}

output "ami" {
  value = aws_launch_template.Application.image_id
   description = "Ami used by launch template"
}
