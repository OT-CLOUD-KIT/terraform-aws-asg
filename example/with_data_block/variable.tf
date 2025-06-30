# === General Configuration ===

variable "ami_id" {
  description = "AMI ID to launch instances with"
  type        = string
  default     = "ami-020cba7c55df1f615"
}

variable "instance_type" {
  description = "EC2 instance type (e.g., t3.micro)"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "terra"
}

variable "user_data" {
  description = "Optional user_data script for EC2 instances"
  type        = string
  default     = ""
}

variable "device_name" {
  description = "Name of the block device to attach"
  type        = string
  default     = "/dev/xvda"
}

variable "volume_size" {
  description = "Size (in GB) of the EBS volume"
  type        = number
  default     = 10
}

# === Networking ===

variable "associate_public_ip" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = ["sg-04fb2f273d8865af3"]
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ASG"
  type        = list(string)
  default     = ["subnet-08a2aa30dbc179a2b", "subnet-08a2aa30dbc179a2b"]
}

variable "target_group_arns" {
  description = "List of Target Group ARNs to attach to ASG"
  type        = list(string)
  default     = []
}

# === Auto Scaling Group Settings ===

variable "min_size" {
  description = "Minimum number of EC2 instances"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  type        = number
  default     = 1
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
  default     = 1
}

variable "health_check_type" {
  description = "Type of health check (EC2 or ELB)"
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Grace period for health checks (seconds)"
  type        = number
  default     = 300
}

variable "termination_policies" {
  description = "Termination policy list"
  type        = list(string)
  default     = ["Default"]
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {
    Environment = "production"
    Team        = "devops"
  }
}

# === Lifecycle Hook Configuration ===

variable "enable_lifecycle_hook" {
  description = "Whether to enable a lifecycle hook"
  type        = bool
  default     = false
}

variable "lifecycle_transition" {
  description = "Type of lifecycle transition"
  type        = string
  default     = "autoscaling:EC2_INSTANCE_LAUNCHING"
}

variable "heartbeat_timeout" {
  description = "Heartbeat timeout for the lifecycle hook"
  type        = number
  default     = 300
}

variable "default_result" {
  description = "Default result if lifecycle hook times out"
  type        = string
  default     = "CONTINUE"
}

# === Scaling Policies ===

variable "enable_scale_up" {
  description = "Enable scale-up policy"
  type        = bool
  default     = true
}

variable "enable_scale_down" {
  description = "Enable scale-down policy"
  type        = bool
  default     = true
}

variable "scale_up_adjustment" {
  description = "How many instances to add when scaling up"
  type        = number
  default     = 1
}

variable "scale_down_adjustment" {
  description = "How many instances to remove when scaling down"
  type        = number
  default     = -1
}

variable "cooldown" {
  description = "Cooldown period between scaling events (seconds)"
  type        = number
  default     = 300
}

# === CloudWatch Alarms ===

variable "cpu_threshold_up" {
  description = "CPU utilization (%) to trigger scale-up"
  type        = number
  default     = 70
}

variable "cpu_threshold_down" {
  description = "CPU utilization (%) to trigger scale-down"
  type        = number
  default     = 30
}

variable "period" {
  description = "Period for metric collection (seconds)"
  type        = number
  default     = 60
}

variable "evaluation_periods" {
  description = "Number of periods to evaluate before alarm"
  type        = number
  default     = 2
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

variable "lt_sg_id" {
  type    = string
  default = "sg-04fb2f273d8865af3"
}

# Application-related variables
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
  default     = "i-09f81359fbc02b150"
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
  default     = ""
}

variable "listener_rule_priority" {
  description = "Priority of the listener rule"
  type        = number
  default     = 100
}

variable "listener_rule_host_headers" {
  description = "List of host headers for the listener rule condition"
  type        = list(string)
  default     = []
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
