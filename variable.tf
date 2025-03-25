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
  default     = "ami-0557a15b87f6559cf"
  description = "Ami on which instance shuold be running"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Type of Instance required"
}

variable "vpc_zone_identifier_subnet" {
  type        = string
  default     = "subnet-0476f004001335518"
  description = "Subnet In which ASG will be working"
}

variable "vpc_zone_identifier_subnet2" {
  type        = string
  default     = "subnet-0476f004001335518"
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
  type        = string
  default     = null
  description = "Subnet Id for asg"
}

variable "availability_zone" {
  type        = any
  default     = ["us-east-2a", "us-east-2b"]
  description = "Availabilty zones in which servers will be created for asg"
}

variable "security_group" {
  type        = string
  default     = "sg-05a1f70335f1ed805"
  description = "Security Groups in which servers will be created for asg"
}

variable "creation_token" {
  type        = string
  default     = "EFS_Token"
  description = "Enter a unique token name for identification"
}

variable "alarm_description" {
  type        = string
  default     = "asg-scale-up-cpu-alarm"
  description = "asg Description"
}

variable "metric_name" {
  type        = string
  default     = "CPUUtilization"
  description = "Name of Monitoring metrics"
}

variable "namespace" {
  type        = string
  default     = "AWS/EC2"
  description = "Namespace for cloudwatch"
}

variable "comparison_operator_scale_up" {
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
  description = "Scale up Comparison Operator"
}

variable "period" {
  type        = number
  default     = "120"
  description = "Conquerent Period"
}

variable "statistic" {
  type        = string
  default     = "Average"
  description = "Cloud watch statistic "
}

variable "alarm_description_scale_down" {
  type        = string
  default     = "asg-scale-down-cpu-alarm"
  description = "asg cloud watch alarm Description"
}

variable "comparison_operator_scale_down" {
  type        = string
  default     = "LessThanOrEqualToThreshold"
  description = "Scale down Comparison Operator"
}

variable "adjustment_type" {
  type        = string
  default     = "ChangeInCapacity"
  description = "Cloud watch adjustment_type "
}

variable "user_data" {
  type        = string
  default     = "/home/sanyamkalra/OT-Cloud-Kit/user_data.sh"
  description = "any user data you want to pass"
}

variable "associate_public_ip_address" {
  type        = bool
  default     = false
  description = "IF you want to assign public ip[ to instances set this as true"
}

variable "device_name" {
  type        = string
  default     = "/dev/sda1"
  description = "Name of your Block device"
}

variable "volume_size" {
  type        = number
  default     = 20
  description = "size of your block device which you are mapping with server"
}

variable "default_result" {
  type        = string
  default     = "ABANDON"
  description = "Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The value for this parameter can be either CONTINUE or ABANDON."
}

variable "heartbeat_timeout" {
  type        = number
  default     = 2000
  description = "Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out"
}

variable "lifecycle_transition" {
  type        = string
  default     = "autoscaling:EC2_INSTANCE_LAUNCHING"
  description = "Instance state to which you want to attach the lifecycle hook."

}

variable "health_check_grace_period" {
  type        = number
  default     = 30
  description = "Time (in seconds) after instance comes into service before checking health."
}

variable "health_check_type" {
  type        = string
  default     = "ELB"
  description = "EC2 or ELB Controls how health checking is done."
}

## Conditional Variables

variable "create_scale_up_policy" {
  type        = bool
  default     = false
  description = "Set this to TRUE if you want to create scale up policy"
}

variable "create_scale_up_alarm" {
  type        = bool
  default     = false
  description = "Set this to TRUE if you want to create scale up Alram"
}

variable "create_scale_down_policy" {
  type        = bool
  default     = false
  description = "Set this to TRUE if you want to create scale down policy"
}

variable "create_scale_down_alarm" {
  type        = bool
  default     = false
  description = "Set this to TRUE if you want to create scale down Alarm"
}
