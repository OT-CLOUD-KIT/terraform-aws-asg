variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

## cloudwatch alarm

variable "alarm_name" {
  description = "name of the cloudwatch alarm"
  type = string
  default = ""
}

variable "associate_public_ip_address" {
  type = bool
  default = false
  description = "associate_public_ip_address to instance"
}
variable "comparison_operator" {
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
  description = "AWS comparison operator"
}

variable "evaluation_periods" {
  type        = number
  default     = 2
  description = "ASG evaluation periods"
}

variable "metric_name" {
  type        = string
  default     = "CPUUtilization"
  description = "CloudWatch alarm name"
}

variable "namespace" {
  type        = string
  default     = "AWS/EC2"
  description = "Alarm namespace"
}

variable "period" {
  type        = number
  default     = 120
  description = "Alarm period"
}

variable "statistic" {
  type        = string
  default     = "Average"
  description = "Alarm statistic"
}

variable "threshold" {
  type        = number
  default     = 70
  description = "Alarm threshold"
}

## launch template

variable "launch_template_name" {
  description = "ASG launch template name"
  type = string
  default = ""
}

variable "volume_name" {
  default = "/dev/xvda"
  type = string
}

variable "ec2_root_volume_size" {
  description = "Size of the root volume (in Gigabytes)"
  type        = number
  default     = 30
}

variable "key_name" {
  description = "EC2 SSH Key Pair name"
  type        = string
  default     = "default"
}

variable "security_groups" {
  description = "security_groups for launch template"
  type = list(any)
  default = [ ]
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "image_id" {
  type        = string
  description = "AMI Id for EC2 Instance"
}

variable "user_data" {
  type        = string
  default     = ""
  description = "User data for Ec2 server"
}

variable "list_of_extra_sg_ids" {
  type        = list(any)
  default     = []
  description = "List of extra security groups to attach to ec2 servers"
}

variable "iam_role_name" {
  description = "name of the iam role"
  type = any
  default = ""
}

### ASG

variable "asg_name" {
  description = "auto scaling group name"
  type = string
  default = ""
}

variable "subnet_ids" {
  description = "subnet ids"
  type = list(any)
  default = []
}

variable "instance_refresh" {
  type        = list(any)
  default     = []
  description = "Enable instance refresh in ASG"
}

variable "asg_max_size" {
  description = "The maximum size of the auto scale group"
  type        = string
  default     = 1
}

variable "asg_min_size" {
  description = "The minimum size of the auto scale group"
  type        = number
  default     = 1
}

variable "asg_desired_capacity" {
  description = "The number of instances that should be running in the group"
  type        = number
  default     = 1
}

variable "asg_health_check_grace_period" {
  description = "Time in seconds after instance comes into service before checking health"
  type        = number
  default     = 300 # Terraform default is 300
}

variable "health_check_type" {
  type        = string
  default     = "ELB"
  description = "Health check type - choose ELB vs EC2"
}

variable "target_group_arns" {
  type = list(string)
  default = [ ]
  description = "provide the target group arn"
}

### ASG Policy

variable "enable_scaling_policy" {
  type        = bool
  default     = false
  description = "description"
}

variable "adjustment_type" {
  type        = string
  default     = "ChangeInCapacity"
  description = "AWS adjustment type"
}

variable "cooldown_period" {
  type        = number
  default     = 600
  description = "ASG cooldown period"
}