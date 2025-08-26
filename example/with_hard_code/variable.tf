
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


variable "enable_public_web_security_group_resource" {
  type        = bool
  description = "This variable is to create Web Security Group"
  default     = true
}


variable "lt_sg_name" {
  type    = string
  default = "dev_lt_sg"
}




variable "applicaton_name" {
  description = "Name of the application for naming the target group"
  type        = string
  default     = "myapp"
}

variable "applicaton_port" {
  description = "Port on which the application is running"
  type        = number
  default     = 8080
}

variable "applicaton_health_check_target" {
  description = "Path to use for ALB health checks"
  type        = string
  default     = "/health"
}

# Target group configuration
variable "tg_target_type" {
  description = "Target type for the ALB target group (e.g., instance, ip, lambda)"
  type        = string
  default     = "instance"
}

variable "tg_protocol" {
  description = "Protocol used by the target group (e.g., HTTP, HTTPS)"
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "VPC ID where the ALB target group will be created"
  type        = string
  default     = "vpc-0bfa15004ff55e107"
}

variable "instance_id" {
  description = "Instance ID to attach to the target group"
  type        = string
  default     = "i-03ef0d37e18b33c09"
}

# Listener rule configuration (optional)
variable "add_listener_rule" {
  description = "Whether to add an ALB listener rule"
  type        = bool
  default     = false
}

variable "listener_arn" {
  description = "ARN of the ALB listener to attach the rule to"
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-east-1:557186391124:listener/app/d-ot-bp-alb/e3ce1e8c9d6d78af/d3c61d8b8d9943e9"
}

variable "listener_rule_priority" {
  description = "Priority of the listener rule"
  type        = number
  default     = 100
}

variable "listener_rule_host_headers" {
  description = "List of host headers for the listener rule condition"
  type        = list(string)
  default     = ["myapp.example.com"]
}

# Naming Convention Inputs
variable "env" {
  type        = string
  description = "Environment (d, p, q, s, g)"
  default     = "p"
  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of: d, p, q, s, g"
  }
}

variable "bu" {
  type        = string
  description = "Business unit (max 10 characters)"
  default     = "BP"
  validation {
    condition     = length(var.bu) <= 10
    error_message = "Business unit name must be <= 10 characters"
  }
}

variable "app" {
  type        = string
  description = "Application name (max 10 characters)"
  default     = "database"
  validation {
    condition     = length(var.app) <= 10
    error_message = "App name must be <= 10 characters"
  }
}

variable "program" {
  type        = string
  description = "Program name (e.g., ot-cloud-kit)"
  default     = "OT"
}

variable "resource" {
  type        = string
  description = "Optional resource name (max 15 characters)"
  default     = ""
  validation {
    condition     = length(var.resource) <= 15
    error_message = "Resource name must be <= 15 characters"
  }
}

variable "team" {
  type        = string
  description = "Team owner or contact (e.g., devops@example.com)"
  default     = "infra"
}

variable "region" {
  type        = string
  description = "AWS Region where resources will be deployed"
  default     = "us-east-1"
}

# Optional Random Name Generator
variable "enabled_features" {
  type        = list(string)
  description = "List of enabled features for name generation"
  default     = []
}

variable "create" {
  type        = bool
  description = "Whether to create resources (module-level toggle)"
  default     = true
}

variable "random_alphanumeric_len" {
  type        = number
  description = "Length of random alphanumeric string to append (1 to 4)"
  default     = 2
  validation {
    condition     = var.random_alphanumeric_len >= 1 && var.random_alphanumeric_len <= 4
    error_message = "Length must be between 1 and 4"
  }
}

variable "special" {
  type        = bool
  description = "Include special characters in generated names"
  default     = false
}

variable "upper" {
  type        = bool
  description = "Include uppercase characters in generated names"
  default     = false
}

variable "number" {
  type        = bool
  description = "Include numbers in generated names"
  default     = true
}

variable "gen_no_of_names" {
  type        = number
  description = "How many names to generate using random naming logic"
  default     = 1
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

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "target_group_arns" {
  description = "List of ALB/NLB target group ARNs."
  type        = string
  default     = ""
}