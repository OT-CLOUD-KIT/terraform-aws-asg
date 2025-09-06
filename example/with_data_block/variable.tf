
# Launch Template (LT)
variable "ami_id" {
  description = "AMI ID to launch EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type (e.g., t2.micro)."
  type        = string
}

variable "key_name" {
  description = "SSH key name to connect to instance."
  type        = string
}

 

variable "device_name" {
  description = "EBS device name (e.g., /dev/xvda)."
  type        = string
}

variable "volume_size" {
  description = "Size of EBS volume in GB."
  type        = number
  default     = 20
}

variable "volume_type" {
  description = "EBS volume type (e.g., gp3, io1)."
  type        = string
  default     = "gp3"
}

variable "ebs_delete_on_termination" {
  description = "Whether to delete EBS volume on instance termination."
  type        = bool
  default     = true
}

variable "enable_capacity_reservation" {
  description = "Enable capacity reservation configuration."
  type        = bool
  default     = false
}

variable "capacity_reservation_preference" {
  description = "Capacity reservation preference (open or none)."
  type        = string
  default     = "open"
}

variable "enable_cpu_options" {
  description = "Enable CPU options block."
  type        = bool
  default     = false
}

variable "cpu_core_count" {
  description = "Number of CPU cores."
  type        = number
  default     = null
}

variable "cpu_threads_per_core" {
  description = "Threads per core."
  type        = number
  default     = null
}

variable "enable_credit_specification" {
  description = "Enable credit specification for T family instances."
  type        = bool
  default     = false
}

variable "cpu_credits" {
  description = "Credit specification (standard/unlimited)."
  type        = string
  default     = "standard"
}

variable "disable_api_stop" {
  description = "Prevent instance from being stopped via API."
  type        = bool
  default     = false
}

variable "disable_api_termination" {
  description = "Prevent instance from being terminated via API."
  type        = bool
  default     = false
}

variable "ebs_optimized" {
  description = "Enable EBS optimization."
  type        = bool
  default     = false
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile to attach."
  type        = string
  default     = ""
}

variable "shutdown_behavior" {
  description = "Instance shutdown behavior (stop or terminate)."
  type        = string
  default     = "stop"
}

variable "enable_spot_instance" {
  description = "Enable EC2 Spot instance."
  type        = bool
  default     = false
}



variable "license_arn" {
  description = "License ARN for license manager."
  type        = string
  default     = ""
}

variable "metadata_http_endpoint" {
  description = "Enable instance metadata endpoint."
  type        = string
  default     = "enabled"
}

variable "metadata_http_tokens" {
  description = "Instance metadata token requirement (required/optional)."
  type        = string
  default     = "required"
}

variable "metadata_hop_limit" {
  description = "Hop limit for instance metadata requests."
  type        = number
  default     = 2
}

variable "metadata_tags" {
  description = "Enable instance metadata tags."
  type        = string
  default     = "enabled"
}

variable "monitoring_enabled" {
  description = "Enable detailed CloudWatch monitoring."
  type        = bool
  default     = true
}

variable "associate_public_ip" {
  description = "Associate public IP with EC2."
  type        = bool
  default     = false
}

variable "lt_sg_id" {
  description = "Security group ID for the launch template."
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for EC2 placement."
  type        = string
  default     = ""
}

# ASG
variable "min_size" {
  description = "Minimum instances in ASG."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum instances in ASG."
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired instances in ASG."
  type        = number
  default     = 2
}

variable "health_check_type" {
  description = "Health check type (EC2 or ELB)."
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Grace period in seconds before health checks start."
  type        = number
  default     = 300
}



variable "target_group_arns" {
  description = "List of ALB/NLB target group ARNs."
  type        = string
  default     = ""
}

variable "termination_policies" {
  description = "ASG termination policies."
  type        = list(string)
  default     = ["Default"]
}

# Lifecycle Hook
variable "enable_lifecycle_hook" {
  description = "Enable lifecycle hook."
  type        = bool
  default     = false
}

variable "lifecycle_transition" {
  description = "Transition type (e.g., autoscaling:EC2_INSTANCE_TERMINATING)."
  type        = string
  default     = "autoscaling:EC2_INSTANCE_TERMINATING"
}

variable "heartbeat_timeout" {
  description = "Lifecycle hook heartbeat timeout in seconds."
  type        = number
  default     = 300
}

variable "default_result" {
  description = "Default result if lifecycle hook times out (CONTINUE/ABANDON)."
  type        = string
  default     = "CONTINUE"
}

# Scaling Policies
variable "enable_scale_up" {
  description = "Enable scale-up policy."
  type        = bool
  default     = true
}

variable "scale_up_adjustment" {
  description = "Number of instances to add when scaling up."
  type        = number
  default     = 1
}

variable "cooldown" {
  description = "Cooldown time in seconds between scaling actions."
  type        = number
  default     = 300
}

variable "period" {
  description = "Period in seconds to evaluate the metric."
  type        = number
  default     = 60
}

variable "evaluation_periods" {
  description = "Number of periods to evaluate the metric."
  type        = number
  default     = 2
}

variable "cpu_threshold_up" {
  description = "CPU threshold to trigger scale-up."
  type        = number
  default     = 70
}

variable "enable_scale_down" {
  description = "Enable scale-down policy."
  type        = bool
  default     = true
}

variable "scale_down_adjustment" {
  description = "Number of instances to remove when scaling down."
  type        = number
  default     = -1
}

variable "cpu_threshold_down" {
  description = "CPU threshold to trigger scale-down."
  type        = number
  default     = 30
}



variable "enable_target_tracking" {
  type    = bool
  default = false
}

variable "cpu_target_value" {
  type    = number
  default = 50
}

variable "enable_instance_maintenance_policy" {
  type    = bool
  default = false
}

variable "min_healthy_percentage" {
  type    = number
  default = 50
}

variable "max_healthy_percentage" {
  type    = number
  default = 100
}

variable "enable_mixed_instances" {
  type    = bool
  default = false
}

variable "on_demand_allocation_strategy" {
  type    = string
  default = "prioritized"
}

variable "on_demand_base_capacity" {
  type    = number
  default = 0
}

variable "on_demand_percentage_above_base_capacity" {
  type    = number
  default = 100
}

variable "spot_allocation_strategy" {
  type    = string
  default = "lowest-price"
}

variable "instance_type_overrides" {
  type    = list(string)
  default = []
}


variable "enable_alb_target_group" {
  type    = bool
  default = true
}

variable "applicaton_name" {
  description = "Application name for naming resources"
  type        = string
}

variable "applicaton_port" {
  description = "Port on which the application is running"
  type        = number
  default     = 80
}

variable "tg_target_type" {
  description = "Target type for the target group (instance or ip)"
  type        = string
  default     = "instance"
}

variable "tg_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}



variable "applicaton_health_check_target" {
  description = "Path for health check"
  type        = string
  default     = "/"
}

variable "instance_id" {
  description = "Instance ID to attach to the target group (leave empty for none)"
  type        = string
  default     = ""
}

variable "add_listener_rule" {
  description = "Boolean to decide whether to create listener rule"
  type        = bool
  default     = false
}



variable "listener_rule_priority" {
  description = "Priority of the listener rule"
  type        = number
  default     = 100
}

variable "owner" {
  type =  string
  default = "Nikita"
}

variable "env" {
  type = string
  default = "dev"
  
}

variable "app" {
  type = string
  default = "otcloudkit"
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "enable_lt_sg" {
  description = "Enable or disable the ALB security group"
  type        = bool
  default     = true
}


####################################
# Security Group Rules - Endpoint
####################################
variable "lt_ingress_rules" {
  type = list(object({
    description  = string
    from_port    = number
    to_port      = number
    protocol     = string
    cidr         = optional(list(string))
    ipv6_cidr    = optional(list(string))
    source_SG_ID = optional(string)
  }))
  default = []
}

variable "lt_egress_rules" {
  type = list(object({
    description  = string
    from_port    = number
    to_port      = number
    protocol     = string
    cidr         = optional(list(string))
    ipv6_cidr    = optional(list(string))
    source_SG_ID = optional(string)
  }))
  default = []
}

variable "provisioner" {
  type    = string
  default = "terraform"
}

variable "tags" {
  type    = map(string)
  default = {}
}
