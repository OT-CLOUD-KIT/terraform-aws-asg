# Terraform AWS ASG (Auto Scaling Group) Module

A Terraform module to deploy an Auto Scaling Group (ASG) on AWS with optional Aurora DB integration, ALB listener rules, health checks, and scaling policies.

---


## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |
| <a name="terraform_module"></a> [Terraform](Terraform\module) | >= 1.12.1|


## Resources

This module creates the following resources:

- EC2 Auto Scaling Group and Launch Template
- Security Groups and Rules
- CloudWatch Alarms and Scaling Policies
- ALB Target Group

---

## Architecture

![Architecture](https://github.com/user-attachments/assets/5b5019a4-d2b2-4801-8add-451254f1db8d)

---

## Usage

```hcl

module "asg" {
  source = ""
  
  ami_id              = "ami-020cba7c55df1f615"
  instance_type       = "t2.micro"
  key_name            = "terra"
  user_data           = file("${path.module}/user_data.sh")
  volume_size         = 20
  associate_public_ip = true
  subnet_ids          = ["subnet-08a2aa30dbc179a2b", "subnet-08a2aa30dbc179a2b"]

  target_group_arns = ["arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/my-tg/abc123"]
  lt_sg_id          = "sg-04fb2f273d8865af3"

  min_size                 = 1
  max_size                 = 1
  desired_capacity         = 1
  health_check_type        = "EC2"
  health_check_grace_period = 300
  termination_policies     = ["Default"]

  enable_lifecycle_hook = true
  default_result        = "CONTINUE"

  enable_scale_up   = true
  enable_scale_down = true

  scale_up_adjustment   = 1
  scale_down_adjustment = -1
  cooldown              = 300

  cpu_threshold_up   = 70
  cpu_threshold_down = 30
  period             = 60
  evaluation_periods = 2
}
```

## Resources

| Name                                                                                                                                                          | Type      |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)                                       | resource  |
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group)                                   | resource  |
| [aws_autoscaling_policy.scale_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy)                             | resource  |
| [aws_autoscaling_policy.scale_down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy)                           | resource  |
| [aws_cloudwatch_metric_alarm.scale_up_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm)             | resource  |
| [aws_cloudwatch_metric_alarm.scale_down_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm)           | resource  |


## Inputs

| Name                                                                                          | Description                                               | Type                          | Default                                                      | Required |
|-----------------------------------------------------------------------------------------------|-----------------------------------------------------------|-------------------------------|--------------------------------------------------------------|:--------:|
| <a name="input_ami_id"></a> [ami_id](#input_ami_id)                                           | The AMI ID for the launch template                        | `string`                      | `"ami-020cba7c55df1f615"`                                     |   yes    |
| <a name="input_instance_type"></a> [instance_type](#input_instance_type)                     | EC2 instance type                                         | `string`                      | `"t2.micro"`                                                  |   yes    |
| <a name="input_key_name"></a> [key_name](#input_key_name)                                     | SSH key name to use for the instance                      | `string`                      | `"terra"`                                                     |   yes    |
| <a name="input_lt_sg_id"></a> [lt_sg_id](#input_lt_sg_id)                                     | Security Group ID to attach to launch template            | `string`                      | `"sg-04fb2f273d8865af3"`                                      |   yes    |
| <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids)                               | List of subnet IDs to launch instances into               | `list(string)`                | `["subnet-08a2aa30dbc179a2b", "subnet-08a2aa30dbc179a2b"]`    |   yes    |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)                                           | VPC ID for networking resources                           | `string`                      | `"vpc-0bfa15004ff55e107"`                                     |   yes    |
| <a name="input_min_size"></a> [min_size](#input_min_size)                                     | Minimum size of the Auto Scaling Group                    | `number`                      | `1`                                                           |   yes    |
| <a name="input_max_size"></a> [max_size](#input_max_size)                                     | Maximum size of the Auto Scaling Group                    | `number`                      | `1`                                                           |   yes    |
| <a name="input_desired_capacity"></a> [desired_capacity](#input_desired_capacity)             | Desired capacity of the Auto Scaling Group                | `number`                      | `1`                                                           |   yes    |
| <a name="input_applicaton_name"></a> [applicaton_name](#input_applicaton_name)                | Name of the application                                   | `string`                      | `"myapp"`                                                     |   yes    |
| <a name="input_applicaton_port"></a> [applicaton_port](#input_applicaton_port)                | Application listening port                                | `number`                      | `8080`                                                        |   yes    |
| <a name="input_applicaton_health_check_target"></a> [applicaton_health_check_target](#input_applicaton_health_check_target) | Health check path                         | `string`                      | `"/health"`                                                   |   yes    |
| <a name="input_tg_target_type"></a> [tg_target_type](#input_tg_target_type)                   | Target group target type                                  | `string`                      | `"instance"`                                                  |   yes    |
| <a name="input_tg_protocol"></a> [tg_protocol](#input_tg_protocol)                            | Protocol used by target group                             | `string`                      | `"HTTP"`                                                      |   yes    |
| <a name="input_instance_id"></a> [instance_id](#input_instance_id)                            | Instance ID to register with the target group             | `string`                      | `"i-09f81359fbc02b150"`                                       |   yes    |


___

## Outputs

| Name                                                                                   | Description                                                       |
|----------------------------------------------------------------------------------------|-------------------------------------------------------------------|
| <a name="output_asg_name"></a> [asg_name](#output_asg_name)                            | Name of the Auto Scaling Group created by the ASG module          |
| <a name="output_launch_template_id"></a> [launch_template_id](#output_launch_template_id) | ID of the Launch Template used by the Auto Scaling Group          |
| <a name="output_web_sg_id"></a> [web_sg_id](#output_web_sg_id)                         | Security Group ID created for public web access (if enabled)      |
| <a name="output_target_group_arn"></a> [target_group_arn](#output_target_group_arn)    | Target group ARN created by the alb_target_group module           |


## Contributors

- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)
