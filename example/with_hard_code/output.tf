output "asg_name" {
  value = module.asg.asg_name
}

output "launch_template_id" {
  value = module.asg.launch_template_id
}

output "target_group_arn" {
  value = module.alb_target_group[0].target_group_arn
}
