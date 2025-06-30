# General Configuration
variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
  default     = "ami-020cba7c55df1f615"
}

variable "instance_type" {
  description = "EC2 instance type (e.g., t3.micro)"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name to allow SSH access to the instances"
  type        = string
  default     = "terra"
}

variable "user_data" {
  description = "User data script to run on instance launch"
  type        = string
  default     = ""
}

# EBS Configuration
variable "device_name" {
  description = "Device name for root volume (e.g., /dev/xvda)"
  type        = string
  default     = "/dev/xvda"
}

variable "volume_size" {
  description = "Root EBS volume size in GiB"
  type        = number
  default     = 10
}

# Networking
variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "List of subnet IDs where the instances will be launched"
  type        = list(string)
  default     = ["subnet-08a2aa30dbc179a2b", "subnet-08a2aa30dbc179a2b"]
}

variable "target_group_arns" {
  description = "List of Target Group ARNs to associate with the ASG"
  type        = list(string)
  default     = []
}

# Auto Scaling Group Configuration
variable "min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
  default     = 1
}

variable "desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
  default     = 1
}

variable "health_check_type" {
  description = "Health check type for ASG (EC2 or ELB)"
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Health check grace period in seconds"
  type        = number
  default     = 300
}

variable "termination_policies" {
  description = "List of termination policies for ASG"
  type        = list(string)
  default     = ["Default"]
}

# Tagging
variable "tags" {
  description = "Map of tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "production"
    Team        = "devops"
  }
}

# Lifecycle Hook (Optional)
variable "enable_lifecycle_hook" {
  description = "Whether to enable a lifecycle hook for the ASG"
  type        = bool
  default     = false
}

variable "lifecycle_transition" {
  description = "The lifecycle transition type (e.g., EC2_INSTANCE_LAUNCHING)"
  type        = string
  default     = "autoscaling:EC2_INSTANCE_LAUNCHING"
}

variable "heartbeat_timeout" {
  description = "Heartbeat timeout for lifecycle hook in seconds"
  type        = number
  default     = 300
}

variable "default_result" {
  description = "Result to take if lifecycle hook times out (ABANDON or CONTINUE)"
  type        = string
  default     = "CONTINUE"
}

# Scaling Configuration
variable "enable_scale_up" {
  description = "Enable scale-up policy and alarm"
  type        = bool
  default     = true
}

variable "enable_scale_down" {
  description = "Enable scale-down policy and alarm"
  type        = bool
  default     = true
}

variable "scale_up_adjustment" {
  description = "Number of instances to add when scaling up"
  type        = number
  default     = 1
}

variable "scale_down_adjustment" {
  description = "Number of instances to remove when scaling down"
  type        = number
  default     = -1
}

variable "cooldown" {
  description = "Cooldown period (in seconds) between scaling actions"
  type        = number
  default     = 300
}

# CloudWatch Alarm Configuration
variable "cpu_threshold_up" {
  description = "CPU utilization threshold to trigger scale-up"
  type        = number
  default     = 70
}

variable "cpu_threshold_down" {
  description = "CPU utilization threshold to trigger scale-down"
  type        = number
  default     = 30
}

variable "period" {
  description = "The period (in seconds) over which the specified statistic is applied"
  type        = number
  default     = 60
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the threshold"
  type        = number
  default     = 2
}

# Launch Template Security Group
variable "lt_sg_id" {
  type    = string
  default = "sg-04fb2f273d8865af3"
}

# Naming Convention
variable "bu" {
  description = "Business unit name (e.g., BP, GURUKU). Max 6 characters."
  type        = string
  default     = "BP"

  validation {
    condition     = length(var.bu) <= 10
    error_message = "The business unit name must be less than or equal to 6 characters."
  }
}

variable "program" {
  description = "Name of the program (e.g., OT, BP)."
  type        = string
  default     = "OT"
}

variable "app" {
  description = "Application name (e.g., network, shared). Max 6 characters."
  type        = string
  default     = "database"

  validation {
    condition     = length(var.app) <= 10
    error_message = "The app name must be less than or equal to 6 characters."
  }
}

variable "env" {
  description = "Environment code: 'd' (dev), 'p' (prod), 'q' (qa), 's' (stage), 'g' (global)."
  type        = string
  default     = "p"

  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of 'd', 'p', 'q', 's', 'g'."
  }
}

variable "team" {
  description = "Team email responsible for the application (e.g., digitalops@gehealthcare.com)."
  type        = string
  default     = "infra"
}

variable "region" {
  description = "AWS region (e.g., us-east-1, ap-south-1)."
  type        = string
  default     = "us-east-1"
}
