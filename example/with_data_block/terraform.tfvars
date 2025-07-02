# Launch Template (LT)
ami_id                          = "ami-020cba7c55df1f615"
instance_type                   = "t2.micro"
key_name                        = "terra"
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
associate_public_ip = false
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

# Security Group
enable_public_web_security_group_resource = true
lt_sg_name                                = "asg-lt-sg"

# Target Group & Listener
applicaton_name                = "myapp"
applicaton_port                = 8080
applicaton_health_check_target = "/health"
tg_target_type                 = "instance"
tg_protocol                    = "HTTP"
instance_id                    = "i-03ef0d37e18b33c09"
add_listener_rule              = true
listener_rule_priority         = 100
listener_rule_host_headers     = ["myapp.example.com"]

# Naming Conventions
env      = "d"
bu       = "BP"
app      = "db"
program  = "OT"
resource = "asg"
team     = "devops"
region   = "us-east-1"

# Optional Random Naming
enabled_features        = ["asg", "lt"]
create                  = true
random_alphanumeric_len = 2
special                 = false
upper                   = false
number                  = true
gen_no_of_names         = 1
