module "asg" {
  source = "../.."

  ami_id              = var.ami_id
  instance_type       = var.instance_type
  key_name            = var.key_name
  user_data           = file("${path.module}/user_data.sh")
  device_name         = var.device_name
  volume_size         = var.volume_size
  associate_public_ip = var.associate_public_ip
  subnet_ids          = data.terraform_remote_state.network.outputs.private_subnets
  target_group_arns   = [module.alb_target_group.target_group_arn]
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  lt_sg_id            = var.enable_public_web_security_group_resource ? module.lt_security_group[0].sg_id : var.lt_sg_id
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  termination_policies      = var.termination_policies
 bu                = var.bu
  program           = var.program
  app               = var.app
  team              = var.team
  env               = var.env


  enable_lifecycle_hook = var.enable_lifecycle_hook
  lifecycle_transition  = var.lifecycle_transition
  heartbeat_timeout     = var.heartbeat_timeout
  default_result        = var.default_result

  enable_scale_up   = var.enable_scale_up
  enable_scale_down = var.enable_scale_down

  scale_up_adjustment   = var.scale_up_adjustment
  scale_down_adjustment = var.scale_down_adjustment
  cooldown              = var.cooldown

  cpu_threshold_up   = var.cpu_threshold_up
  cpu_threshold_down = var.cpu_threshold_down
  period             = var.period
  evaluation_periods = var.evaluation_periods


}


module "lt_security_group" {
  count               = var.enable_public_web_security_group_resource == true ? 1 : 0
  source              = "OT-CLOUD-KIT/security-groups/aws"
  version             = "1.0.0"
  enable_whitelist_ip = true
  name_sg             = var.lt_sg_name
  vpc_id              = data.terraform_remote_state.network.outputs.vpc_id

  ingress_rule = {
    rules = {
      rule_list = [
        {
          description  = "Rule for port 80"
          from_port    = 80
          to_port      = 80
          protocol     = "tcp"
          cidr         = ["0.0.0.0/0"]
          source_SG_ID = []
        },
        {
          description  = "Rule for port 443"
          from_port    = 443
          to_port      = 443
          protocol     = "tcp"
          cidr         = ["0.0.0.0/0"]
          source_SG_ID = []
        }
      ]
    }
  }

}


module "alb_target_group" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-alb_target_group.git?ref=beta0.1" 

  applicaton_name                = var.applicaton_name
  applicaton_port                = var.applicaton_port
  applicaton_health_check_target = var.applicaton_health_check_target
  tg_target_type                 = var.tg_target_type
  tg_protocol                    = var.tg_protocol
  vpc_id                         = data.terraform_remote_state.network.outputs.vpc_id
  instance_id                    = var.instance_id
  add_listener_rule         = var.add_listener_rule
  listener_arn              = var.listener_arn
  listener_rule_priority    = var.listener_rule_priority
  listener_rule_host_headers = var.listener_rule_host_headers
}







