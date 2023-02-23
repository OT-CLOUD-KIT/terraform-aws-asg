variable "min_size" {
  type        = number
  default     = 1
  description = " Minimum number of Instances to maintained"
}

variable "max_size" {
  type        = number
  default     = 5
  description = " Maximum number of Instances to maintained"
}

variable "desired_size" {
  type        = number
  default     = 2
  description = " desired number of Instance to maintain"
}

variable "ami" {
  type        = string
  default     = "ami-0283a57753b18025b"
  description = "Ami on which instance shuold be running"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Type of Instance required"
}

variable "vpc_zone_identifier_subnet" {
  type        = string
  default     = null
  description = "Subnet In which ASG will be working"
}

variable "vpc_zone_identifier_subnet2" {
  type        = string
  default     = null
  description = "Subnet In which ASG will be working"
}

variable "key_name" {
  type        = string
  default     = "OT"
  description = "Name of the key which will be attached to ec2"
}

variable "name" {
  type        = string
  default     = "Attendance"
  description = "Name for Resources"
}
variable "policy_type_scale_up" {
  type        = string
  default     = "SimpleScaling"
  description = "Mention type of scale up policy"
}
variable "cooldown" {
  type        = number
  default     = "300"
  description = "Cooldown period in seconds"
}
variable "scaling_up_adjustment" {
  type        = number
  default     = "1"
  description = "number of servers you want to scale up if thershold breached"
}

variable "template_version" {
  type        = string
  default     = "$Latest"
  description = "Version of template you want to use"
}

variable "policy_type_scale_down" {
  type        = string
  default     = "SimpleScaling"
  description = "Mention type of scale down policy"
}

variable "scale_down_adjustment" {
  type        = number
  default     = "-1"
  description = "number of servers you want to scale down at once if thershold breached"
}

variable "scale_up_evaluation_periods" {
  type        = number
  default     = "2"
  description = "Number of times cloudwatch evaluate before triggering the asg to scale up "
}

variable "scale_down_evaluation_periods" {
  type        = number
  default     = "2"
  description = "Number of times cloudwatch evaluate before triggering the asg to scale down"
}

variable "scale_up_threshold" {
  type        = number
  default     = "70"
  description = "Threshold after which scale policy will triggered"
}

variable "scale_down_threshold" {
  type        = number
  default     = "50"
  description = "Threshold after which scale down policy will triggered"
}

variable "name_template" {
  type        = string
  default     = "Application_Template"
  description = "Name of Launch Template"
}

variable "comman_tags" {
  type = map(string)
  default = {
    "Project" = "OT-Microservices"
  }
  description = "Comman tags will be defined here"
}

variable "template_tags" {
  type = map(string)
  default = {
    "Name" = "Application template"
    "type" = "Template for attendance"
  }
  description = "Tags for template"
}

variable "server_name" {
  type = map(string)
  default = {
    "Name" = "Server_by_asg"
  }
  description = "Name of server which will be created by asg"
}


variable "cloudwatch_alarm_tags" {
  type = map(string)
  default = {
    "Name" = "Alarm for application"
  }
  description = "tags for cloudwatch alarm"
}

variable "subnet_id" {
  type = string
  default = null
  description = "Subnet Id for asg"
}

variable "availability_zone" {
  type = any
  default = ["us-east-2a", "us-east-2b"]
  description = "Availabilty zones in which servers will be created for asg"
}

variable "security_group" {
  type = string
  default = "sg-06673a7479db3d932"
  description = "Security Groups in which servers will be created for asg"
}

variable "creation_token" {
  type = string
  default = "EFS_Token"
  description = "Enter a unique token name for identification"
}

variable "alarm_description" {
  type = string
  default = "asg-scale-up-cpu-alarm"
  description = "asg Description"
}

variable "metric_name" {
  type = string
  default = "CPUUtilization"
  description = "Name of Monitoring metrics"
}

variable "namespace" {
  type = string
  default = "AWS/EC2"
  description = "Namespace for cloudwatch"
}

variable "comparison_operator_scale_up" {
  type = string
  default = "GreaterThanOrEqualToThreshold"
  description = "Scale up Comparison Operator"
}

variable "period" {
  type = number
  default = "120"
  description = "Conquerent Period"
}

variable "statistic" {
  type = string
  default = "Average"
  description = "Cloud watch statistic "
}

variable "alarm_description_scale_down" {
  type = string
  default = "asg-scale-down-cpu-alarm"
  description = "asg cloud watch alarm Description"
}

variable "comparison_operator_scale_down" {
  type = string
  default = "LessThanOrEqualToThreshold"
  description = "Scale down Comparison Operator"
} 

variable "adjustment_type" {
  type = string
  default = "ChangeInCapacity"
  description = "Cloud watch adjustment_type "
}
