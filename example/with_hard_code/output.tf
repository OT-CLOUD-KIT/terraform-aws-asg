output "asg_name" {
  value = module.asg.asg_name
}

output "launch_template_id" {
  value = module.asg.launch_template_id
}


output "web_sg_id" {
  value = var.enable_public_web_security_group_resource ? module.lt_security_group[0].sg_id : null
}

output "target_group_arn" {
  value = module.alb_target_group[0].target_group_arn
}
