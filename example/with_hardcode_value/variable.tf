# === General EC2/Launch Template Settings ===

variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 instances"
  default     = "ami-0abcd1234ef567890"
}

variable "instance_type" {
  type        = string
  description = "Instance type (e.g., t3.micro)"
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "Key pair name for SSH access"
  default     = "terra"
}

variable "user_data" {
  type        = string
  description = "User data script file path"
  default     = "user_data.sh"
}

variable "device_name" {
  type        = string
  description = "Device name for block volume (e.g., /dev/xvda)"
  default     = "/dev/xvda"
}

variable "volume_size" {
  type        = number
  description = "EBS volume size in GB"
  default     = 8
}

variable "associate_public_ip" {
  type        = bool
  description = "Whether to associate a public IP address"
  default     = true
}

variable "lt_sg_id" {
  type        = string
  description = "Security Group ID to associate with Launch Template (optional)"
  default     = "sg-04fb2f273d8865af3"
}

variable "enable_public_web_security_group_resource" {
  type        = bool
  description = "Whether to create a public-facing security group for web access"
  default     = true
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where resources will be deployed"
  default     = "vpc-0bfa15004ff55e107"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the Auto Scaling Group"
  default     = ["subnet-08a2aa30dbc179a2b", "subnet-08a2aa30dbc179a2b"]
}

variable "lt_sg_name" {
  type        = string
  description = "Name of the security group if created inside the module"
  default     = "asg-web-sg"
}

# === Auto Scaling Group Settings ===

variable "min_size" {
  type        = number
  description = "Minimum number of instances in the ASG"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum number of instances in the ASG"
  default     = 2
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of instances in the ASG"
  default     = 1
}

# === Health Check ===

variable "health_check_type" {
  type        = string
  description = "Health check type: EC2 or ELB"
  default     = "EC2"
}

variable "health_check_grace_period" {
  type        = number
  description = "Time (in seconds) to wait before checking health status"
  default     = 300
}

variable "termination_policies" {
  type        = list(string)
  description = "List of termination policies for ASG"
  default     = ["Default"]
}

# === Tags ===

variable "tags" {
  type        = map(string)
  description = "Tags to assign to resources"
  default     = {
    Environment = "dev"
    Project     = "asg-wrapper"
    Team        = "infra"
  }
}

# === Lifecycle Hook ===

variable "enable_lifecycle_hook" {
  type        = bool
  description = "Enable lifecycle hook for the ASG"
  default     = false
}

variable "lifecycle_transition" {
  type        = string
  description = "Lifecycle transition type"
  default     = "autoscaling:EC2_INSTANCE_TERMINATING"
}

variable "heartbeat_timeout" {
  type        = number
  description = "Time (in seconds) to wait for lifecycle hook completion"
  default     = 300
}

variable "default_result" {
  type        = string
  description = "Action to take if the lifecycle hook times out or fails"
  default     = "CONTINUE"
}

# === Scaling Policies ===

variable "enable_scale_up" {
  type        = bool
  description = "Enable scale-up policy"
  default     = true
}

variable "enable_scale_down" {
  type        = bool
  description = "Enable scale-down policy"
  default     = true
}

variable "scale_up_adjustment" {
  type        = number
  description = "Number of instances to add during scale-up"
  default     = 1
}

variable "scale_down_adjustment" {
  type        = number
  description = "Number of instances to remove during scale-down"
  default     = -1
}

variable "cooldown" {
  type        = number
  description = "Cooldown period (in seconds) for scaling actions"
  default     = 300
}

# === CloudWatch Alarm Settings ===

variable "cpu_threshold_up" {
  type        = number
  description = "CPU threshold (%) for scaling up"
  default     = 70
}

variable "cpu_threshold_down" {
  type        = number
  description = "CPU threshold (%) for scaling down"
  default     = 30
}

variable "period" {
  type        = number
  description = "Evaluation period (in seconds) for alarms"
  default     = 300
}

variable "evaluation_periods" {
  type        = number
  description = "Number of periods to evaluate before triggering alarm"
  default     = 2
}

# === ALB Target Group Settings ===

variable "applicaton_name" {
  type        = string
  description = "Application name used in naming ALB target group"
  default     = "demo-app"
}

variable "applicaton_port" {
  type        = number
  description = "Port for ALB target group"
  default     = 80
}

variable "applicaton_health_check_target" {
  type        = string
  description = "Health check path for ALB target group"
  default     = "/"
}

variable "tg_target_type" {
  type        = string
  description = "Target type for ALB target group (e.g., instance or ip)"
  default     = "instance"
}

variable "tg_protocol" {
  type        = string
  description = "Protocol used in ALB target group (e.g., HTTP or HTTPS)"
  default     = "HTTP"
}

variable "instance_id" {
  type        = string
  description = "Optional EC2 instance ID to register with ALB target group"
  default     = "i-09f81359fbc02b150"
}

# === Listener Rule Settings ===

variable "add_listener_rule" {
  type        = bool
  description = "Whether to add a listener rule for host-based routing"
  default     = false
}

variable "listener_arn" {
  type        = string
  description = "ARN of the ALB listener"
  default     = ""
}

variable "listener_rule_priority" {
  type        = number
  description = "Priority of the listener rule"
  default     = 100
}

variable "listener_rule_host_headers" {
  type        = list(string)
  description = "List of host headers for the listener rule"
  default     = ["example.com"]
}

# === Naming Convention Inputs ===

variable "env" {
  type        = string
  description = "Environment (d, p, q, s, g)"
  default     = "d"
  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of: d, p, q, s, g"
  }
}

variable "bu" {
  type        = string
  description = "Business unit (max 10 characters)"
  default     = "bp"
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

# === Optional Random Name Generator ===

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
