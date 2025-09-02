
########################LT################

variable "ami_id" {
  description = "AMI ID to launch the EC2 instance."
  type        = string
  default = "ami-020cba7c55df1f615"
}

variable "instance_type" {
  description = "EC2 instance type (e.g., t2.micro, t3.large)."
  type        = string
  default = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name to access the EC2 instance."
  type        = string
  default = "terra"
}

variable "user_data" {
  description = "User data script to be run on instance launch."
  type        = string
  default     = ""
}

variable "device_name" {
  description = "Name of the block device (e.g., /dev/xvda)."
  type        = string
  default = "/dev/xvda"
}

variable "volume_size" {
  description = "Size of the EBS volume in GB."
  type        = number
  default     = 20
}

variable "volume_type" {
  description = "Type of the EBS volume (e.g., gp2, gp3, io1)."
  type        = string
  default     = "gp3"
}

variable "ebs_delete_on_termination" {
  description = "Whether the EBS volume should be deleted on instance termination."
  type        = bool
  default     = true
}

variable "enable_capacity_reservation" {
  description = "Enable capacity reservation settings."
  type        = bool
  default     = false
}

variable "capacity_reservation_preference" {
  description = "Capacity reservation preference (e.g., open, none)."
  type        = string
  default     = "open"
}

variable "enable_cpu_options" {
  description = "Enable custom CPU options."
  type        = bool
  default     = false
}

variable "cpu_core_count" {
  description = "Number of CPU cores for the instance."
  type        = number
  default     = null
}

variable "cpu_threads_per_core" {
  description = "Number of threads per core."
  type        = number
  default     = null
}

variable "enable_credit_specification" {
  description = "Enable credit specification for T instance types."
  type        = bool
  default     = false
}

variable "cpu_credits" {
  description = "Credit option for burstable instances (standard/unlimited)."
  type        = string
  default     = "standard"
}

variable "disable_api_stop" {
  description = "Prevents the instance from being stopped via the API."
  type        = bool
  default     = false
}

variable "disable_api_termination" {
  description = "Prevents the instance from being terminated via the API."
  type        = bool
  default     = false
}

variable "ebs_optimized" {
  description = "Enable EBS-optimized instance."
  type        = bool
  default     = false
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile name to attach to the EC2 instance."
  type        = string
  default     = null
}

variable "shutdown_behavior" {
  description = "Shutdown behavior (e.g., stop or terminate)."
  type        = string
  default     = "stop"
}

variable "enable_spot_instance" {
  description = "Enable launching as Spot instance."
  type        = bool
  default     = false
}



variable "license_arn" {
  description = "ARN of the license configuration to associate."
  type        = string
  default     = null
}

variable "metadata_http_endpoint" {
  description = "Whether the metadata endpoint is enabled (enabled/disabled)."
  type        = string
  default     = "enabled"
}

variable "metadata_http_tokens" {
  description = "State of token usage for instance metadata requests (required/optional)."
  type        = string
  default     = "required"
}

variable "metadata_hop_limit" {
  description = "The desired HTTP PUT response hop limit for instance metadata requests."
  type        = number
  default     = 2
}

variable "metadata_tags" {
  description = "Enable instance metadata tags (enabled/disabled)."
  type        = string
  default     = "enabled"
}

variable "monitoring_enabled" {
  description = "Enable detailed CloudWatch monitoring."
  type        = bool
  default     = true
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP with the instance."
  type        = bool
  default     = false
}

variable "lt_sg_id" {
  type    = string
  default = "sg-04fb2f273d8865af3"
}


variable "availability_zone" {
  description = "Availability zone to launch the instances in."
  type        = string
  default     = "us-east-1a"
}

variable "min_size" {
  description = "Minimum number of instances in the ASG."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the ASG."
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired number of instances in the ASG."
  type        = number
  default     = 2
}

variable "health_check_type" {
  description = "Health check type for the ASG (e.g., EC2 or ELB)."
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Time (in seconds) that Auto Scaling waits before checking instance health."
  type        = number
  default     = 300
}

variable "subnet_ids" {
  description = "List of subnet IDs for ASG to launch instances in."
  type        = list(string)
}

variable "target_group_arns" {
  description = "List of Target Group ARNs to associate with the ASG."
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-east-1:557186391124:targetgroup/demo/87a9b2963a03085c"
}

variable "termination_policies" {
  description = "List of termination policies for the ASG."
  type        = list(string)
  default     = ["Default"]
}



variable "enable_lifecycle_hook" {
  description = "Enable lifecycle hook for instance launch/termination."
  type        = bool
  default     = false
}

variable "lifecycle_transition" {
  description = "The instance state to which you want to attach the lifecycle hook (e.g., autoscaling:EC2_INSTANCE_TERMINATING)."
  type        = string
  default     = "autoscaling:EC2_INSTANCE_TERMINATING"
}

variable "heartbeat_timeout" {
  description = "Maximum time in seconds to wait before continuing lifecycle hook."
  type        = number
  default     = 300
}

variable "default_result" {
  description = "Action to take when lifecycle hook times out (CONTINUE or ABANDON)."
  type        = string
  default     = "CONTINUE"
}


variable "enable_scale_up" {
  description = "Enable scale-up policy based on CPU usage."
  type        = bool
  default     = true
}

variable "scale_up_adjustment" {
  description = "Number of instances to add on scale-up."
  type        = number
  default     = 1
}

variable "cooldown" {
  description = "Cooldown period (in seconds) between scaling actions."
  type        = number
  default     = 300
}

variable "period" {
  description = "The period over which the specified statistic is applied."
  type        = number
  default     = 60
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold."
  type        = number
  default     = 2
}

variable "cpu_threshold_up" {
  description = "The CPU utilization threshold to trigger scale-up."
  type        = number
  default     = 70
}

variable "enable_scale_down" {
  description = "Enable scale-down policy based on CPU usage."
  type        = bool
  default     = true
}

variable "scale_down_adjustment" {
  description = "Number of instances to remove on scale-down."
  type        = number
  default     = -1
}

variable "cpu_threshold_down" {
  description = "The CPU utilization threshold to trigger scale-down."
  type        = number
  default     = 30
}


variable "enable_instance_maintenance_policy" {
  description = "Enable instance maintenance policy."
  type        = bool
  default     = false
}

variable "min_healthy_percentage" {
  description = "Minimum healthy percentage for instance maintenance."
  type        = number
  default     = 50
}

variable "max_healthy_percentage" {
  description = "Maximum healthy percentage for instance maintenance."
  type        = number
  default     = 100
}

variable "enable_mixed_instances" {
  description = "Enable mixed instances policy."
  type        = bool
  default     = false
}

variable "on_demand_allocation_strategy" {
  description = "On-demand allocation strategy."
  type        = string
  default     = "prioritized"
}

variable "on_demand_base_capacity" {
  description = "On-demand base capacity."
  type        = number
  default     = 0
}

variable "on_demand_percentage_above_base_capacity" {
  description = "Percentage of on-demand instances above base capacity."
  type        = number
  default     = 100
}

variable "spot_allocation_strategy" {
  description = "Spot allocation strategy."
  type        = string
  default     = "lowest-price"
}

variable "instance_type_overrides" {
  description = "List of instance types for mixed instances policy overrides."
  type        = list(string)
  default     = []
}

variable "enable_target_tracking" {
  description = "Enable target tracking policy."
  type        = bool
  default     = false
}

variable "cpu_target_value" {
  description = "Target CPU value for target tracking."
  type        = number
  default     = 60
}



variable "owner" {
  type = string
  default = ""
}

variable "env" {
  type = string
  default = "dev"
  
}

variable "app" {
  type = string
  default = "otcloudkit"
  
}