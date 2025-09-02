# Launch Template (LT)
ami_id                          = "ami-0360c520857e3138f"
instance_type                   = "t2.micro"
key_name                        = "otbp-key"
device_name                     = "/dev/xvda"
volume_size                     = 8
volume_type                     = "gp3"
ebs_delete_on_termination       = true
enable_capacity_reservation     = false
capacity_reservation_preference = "open"

enable_cpu_options   = false
cpu_core_count       = 1
cpu_threads_per_core = 1

enable_credit_specification = false
cpu_credits                 = "standard"

disable_api_stop          = false
disable_api_termination   = false
ebs_optimized             = true
iam_instance_profile_name = ""
shutdown_behavior         = "stop"

enable_spot_instance = false
license_arn          = ""

metadata_http_endpoint = "enabled"
metadata_http_tokens   = "required"
metadata_hop_limit     = 2
metadata_tags          = "enabled"

monitoring_enabled  = true
associate_public_ip = true
lt_sg_id            = ""
availability_zone   = "us-east-1a"

# ASG
min_size                  = 1
max_size                  = 3
desired_capacity          = 2
health_check_type         = "EC2"
health_check_grace_period = 300
termination_policies      = ["OldestInstance", "Default"]

# Lifecycle Hook
enable_lifecycle_hook = false
lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
heartbeat_timeout     = 300
default_result        = "CONTINUE"

# Scaling Policies
enable_scale_up     = true
scale_up_adjustment = 1
cooldown            = 300
period              = 60
evaluation_periods  = 2
cpu_threshold_up    = 75

enable_scale_down     = true
scale_down_adjustment = -1
cpu_threshold_down    = 30

# Target Tracking Scaling
enable_target_tracking = false
cpu_target_value       = 50

# Instance Maintenance Policy
enable_instance_maintenance_policy = true
min_healthy_percentage             = 70
max_healthy_percentage             = 100

# Mixed Instances Policy
enable_mixed_instances                   = false
on_demand_allocation_strategy            = "prioritized"
on_demand_base_capacity                  = 1
on_demand_percentage_above_base_capacity = 50
spot_allocation_strategy                 = "lowest-price"
instance_type_overrides                  = ["t2.micro", "t3.micro"]



applicaton_name                = "myapp"
applicaton_port                = 80
tg_target_type                 = "instance"
tg_protocol                    = "HTTP"
applicaton_health_check_target = "/"
instance_id                    = "" # Leave empty if no instance needs to be attached
add_listener_rule              = true
listener_rule_priority         = 1
listener_arn = "arn:aws:elasticloadbalancing:us-east-1:240851516795:listener/app/prod-otcloudkit-alb/03c51a36e526c095/6e30373262937103"

vpc_id     = "vpc-0df93e00530080785"
subnet_ids = ["subnet-0734d3239355739e8", "subnet-014a0dabec0dd2b22"]
enable_alb_target_group = true
target_group_arns = ""

env = "dev"
owner = "NikitA"
app = "otcloudkit"

enable_lt_sg = true


lt_ingress_rules = [
  {
    description  = "Allow HTTPS from ALB SG"
    from_port    = 443
    to_port      = 443
    protocol     = "tcp"
    cidr         = ["0.0.0.0/0"]
    source_SG_ID = ""
  },
   {
    description  = "Allow HTTPS from ALB SG"
    from_port    = 22
    to_port      = 22
    protocol     = "tcp"
    cidr         = ["0.0.0.0/0"]
    source_SG_ID = ""
  },

   {
    description  = "Allow HTTPS from ALB SG"
    from_port    = 80
    to_port      = 80
    protocol     = "tcp"
    cidr         = ["0.0.0.0/0"]
    source_SG_ID = ""
  }
]

lt_egress_rules = [
  {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr        = ["0.0.0.0/0"]
  }
]

provisioner = "terraform"
tags = {
  Environment = "dev"
  Owner       = "Nikita"
}