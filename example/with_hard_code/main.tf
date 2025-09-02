
module "asg" {
  source = "../../"

  # Global naming
 env = var.env
 owner = var.owner
 app = var.app

  # Launch Template
  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  key_name                  = var.key_name
  user_data                 = file("${path.module}/user_data.sh")
  device_name               = var.device_name
  volume_size               = var.volume_size
  volume_type               = var.volume_type
  ebs_delete_on_termination = var.ebs_delete_on_termination

  enable_capacity_reservation     = var.enable_capacity_reservation
  capacity_reservation_preference = var.capacity_reservation_preference

  enable_cpu_options   = var.enable_cpu_options
  cpu_core_count       = var.cpu_core_count
  cpu_threads_per_core = var.cpu_threads_per_core

  enable_credit_specification = var.enable_credit_specification
  cpu_credits                 = var.cpu_credits

  disable_api_stop        = var.disable_api_stop
  disable_api_termination = var.disable_api_termination

  ebs_optimized             = var.ebs_optimized
  iam_instance_profile_name = var.iam_instance_profile_name
  shutdown_behavior         = var.shutdown_behavior
  enable_spot_instance      = var.enable_spot_instance

  license_arn = var.license_arn

  metadata_http_endpoint = var.metadata_http_endpoint
  metadata_http_tokens   = var.metadata_http_tokens
  metadata_hop_limit     = var.metadata_hop_limit
  metadata_tags          = var.metadata_tags

  monitoring_enabled  = var.monitoring_enabled
  associate_public_ip = var.associate_public_ip
  lt_sg_id = var.enable_lt_sg ? values(module.lt_security_group)[0].sg_id : var.lt_sg_id
  availability_zone   = var.availability_zone

  # ASG
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  subnet_ids = var.subnet_ids

  target_group_arns = var.enable_alb_target_group ? module.alb_target_group[0].target_group_arn : var.target_group_arns

  termination_policies = var.termination_policies

  # Lifecycle
  enable_lifecycle_hook = var.enable_lifecycle_hook
  lifecycle_transition  = var.lifecycle_transition
  heartbeat_timeout     = var.heartbeat_timeout
  default_result        = var.default_result

  # Scaling
  enable_scale_up     = var.enable_scale_up
  scale_up_adjustment = var.scale_up_adjustment
  cooldown            = var.cooldown
  period              = var.period
  evaluation_periods  = var.evaluation_periods
  cpu_threshold_up    = var.cpu_threshold_up

  enable_scale_down     = var.enable_scale_down
  scale_down_adjustment = var.scale_down_adjustment
  cpu_threshold_down    = var.cpu_threshold_down

  # Target Tracking Policy
  enable_target_tracking = var.enable_target_tracking
  cpu_target_value       = var.cpu_target_value

  # Optional Lifecycle Hooks
  enable_instance_maintenance_policy = var.enable_instance_maintenance_policy
  min_healthy_percentage             = var.min_healthy_percentage
  max_healthy_percentage             = var.max_healthy_percentage

  # Mixed Instances Policy
  enable_mixed_instances                   = var.enable_mixed_instances
  on_demand_allocation_strategy            = var.on_demand_allocation_strategy
  on_demand_base_capacity                  = var.on_demand_base_capacity
  on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
  spot_allocation_strategy                 = var.spot_allocation_strategy
  instance_type_overrides                  = var.instance_type_overrides
}



module "lt_security_group" {
    for_each    = var.enable_lt_sg ? { enabled = true } : {}

  source      = "git@github.com:OT-CLOUD-KIT/terraform-aws-security-groups.git?ref=v0.0.2"
  name_sg     = "${var.env}-${var.app}-lt-sg"
  vpc_id      = var.vpc_id
  provisioner = var.provisioner
  tags        = var.tags
  ingress_rule = var.lt_ingress_rules
  egress_rule  = var.lt_egress_rules
}


module "alb_target_group" {
    count               = var.enable_alb_target_group == true ? 1 : 0

  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-alb_target_group.git?ref=Feature"
  applicaton_name                 = var.applicaton_name
  applicaton_port                 = var.applicaton_port
  tg_target_type                  = var.tg_target_type
  tg_protocol                      = var.tg_protocol
   vpc_id                         = var.vpc_id
  applicaton_health_check_target  = var.applicaton_health_check_target
  instance_id                      = var.instance_id
  add_listener_rule                = var.add_listener_rule
 listener_arn                   = var.listener_arn
  listener_rule_priority           = var.listener_rule_priority
}











