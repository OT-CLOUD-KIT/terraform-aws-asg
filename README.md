# microservice

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.31.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora"></a> [aurora](#module\_aurora) | ../aurora | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.asg_scale_up_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_cloudwatch_metric_alarm.foobar](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_instance_profile.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_launch_template.lt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb_listener_rule.listener_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.rds_access_from_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.server_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.server_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.server_tg_health_check_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.server_tg_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_iam_policy_document.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_subnets.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |


## Usage

module "Asg" {
  source                            = "./"
  alarm_name                        = local.alarm_name
  comparison_operator               = var.comparison_operator
  evaluation_periods                = var.evaluation_periods
  metric_name                       = local.metric_name
  namespace                         = var.namespace
  period                            = var.period
  statistic                         = var.statistic
  threshold                         = var.threshold

  associate_public_ip_address       = var.associate_public_ip_address
  security_groups                   = [module.AsgSecurityGroup[0].sg_id]

  launch_template_name              = local.launch_template_name
  volume_name                       = var.volume_name
  ec2_root_volume_size              = var.ec2_root_volume_size
  key_name                          = var.key_name
  instance_type                     = var.instance_type
  image_id                          = var.image_id
  user_data                         = var.user_data
  list_of_extra_sg_ids              = var.list_of_extra_sg_ids
  iam_role_name                     = var.iam_role_name

  asg_name                          = local.asg_name
  subnet_ids                        = var.subnets_id
  instance_refresh                  = var.instance_refresh
  asg_max_size                      = var.asg_max_size
  asg_min_size                      = var.asg_min_size
  asg_desired_capacity              = var.asg_desired_capacity
  asg_health_check_grace_period     = var.asg_health_check_grace_period
  health_check_type                 = var.health_check_type
  target_group_arns                 = var.target_group_arns
  enable_scaling_policy             = var.enable_scaling_policy
  adjustment_type                   = var.adjustment_type
  cooldown_period                   = var.cooldown_period
  tags                              = var.tags
}




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_target_group"></a> [add\_target\_group](#input\_add\_target\_group) | Target group to be added or not | `bool` | `true` | no |
| <a name="input_adjustment_type"></a> [adjustment\_type](#input\_adjustment\_type) | AWS adjustment type | `string` | `"ChangeInCapacity"` | no |
| <a name="input_alb_sg_id"></a> [alb\_sg\_id](#input\_alb\_sg\_id) | Security Group Id attached to load balancer | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | description | `string` | `"hello"` | no |
| <a name="input_asg_desired_capacity"></a> [asg\_desired\_capacity](#input\_asg\_desired\_capacity) | The number of instances that should be running in the group | `string` | `1` | no |
| <a name="input_asg_health_check_grace_period"></a> [asg\_health\_check\_grace\_period](#input\_asg\_health\_check\_grace\_period) | Time in seconds after instance comes into service before checking health | `string` | `300` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | The maximum size of the auto scale group | `string` | `1` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | The minimum size of the auto scale group | `string` | `1` | no |
| <a name="input_comparison_operator"></a> [comparison\_operator](#input\_comparison\_operator) | AWS comparison operator | `string` | `"GreaterThanOrEqualToThreshold"` | no |
| <a name="input_cooldown_period"></a> [cooldown\_period](#input\_cooldown\_period) | ASG cooldown period | `number` | `600` | no |
| <a name="input_create_iam_role"></a> [create\_iam\_role](#input\_create\_iam\_role) | Boolean for adding IAM role or not | `bool` | `false` | no |
| <a name="input_custom_string"></a> [custom\_string](#input\_custom\_string) | Unique name the you want to prepend | `string` | `"aws"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Database Name | `string` | `""` | no |
| <a name="input_db_engine_version"></a> [db\_engine\_version](#input\_db\_engine\_version) | Database engine version | `string` | `"13.7"` | no |
| <a name="input_db_family"></a> [db\_family](#input\_db\_family) | Database parameter group family | `string` | `"postgres13"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | Database instance class | `string` | `"db.t3.small"` | no |
| <a name="input_db_instance_count"></a> [db\_instance\_count](#input\_db\_instance\_count) | Number of database instances (0 to leverage an existing db) | `string` | `1` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | DB Port | `number` | `5432` | no |
| <a name="input_ec2_root_volume_size"></a> [ec2\_root\_volume\_size](#input\_ec2\_root\_volume\_size) | Size of the root volume (in Gigabytes) | `string` | `30` | no |
| <a name="input_enable_aurora"></a> [enable\_aurora](#input\_enable\_aurora) | Boolean to enable Aurora | `bool` | `false` | no |
| <a name="input_enable_scaling_policy"></a> [enable\_scaling\_policy](#input\_enable\_scaling\_policy) | description | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Resource environment tag (i.e. dev, stage, prod) | `string` | `"dev"` | no |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | ASG evaluation periods | `string` | `"2"` | no |
| <a name="input_health_check_healthy_threshold"></a> [health\_check\_healthy\_threshold](#input\_health\_check\_healthy\_threshold) | Number of consecutives checks before a unhealthy target is considered healthy | `string` | `3` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | Seconds between health checks | `string` | `10` | no |
| <a name="input_health_check_matcher"></a> [health\_check\_matcher](#input\_health\_check\_matcher) | HTTP Code(s) that result in a successful response from a target (comma delimited) | `string` | `200` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | Health check path | `string` | `"/ping"` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | Health check port | `string` | `"traffic-port"` | no |
| <a name="input_health_check_timeout"></a> [health\_check\_timeout](#input\_health\_check\_timeout) | Seconds waited before a health check fails | `string` | `5` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | Health check type - choose ELB vs EC2 | `string` | `"ELB"` | no |
| <a name="input_health_check_unhealthy_threshold"></a> [health\_check\_unhealthy\_threshold](#input\_health\_check\_unhealthy\_threshold) | Number of consecutive checks before considering a target unhealthy | `string` | `2` | no |
| <a name="input_host_header"></a> [host\_header](#input\_host\_header) | Host header for host based routing | `string` | n/a | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | AMI Id for EC2 Instance | `string` | n/a | yes |
| <a name="input_instance_refresh"></a> [instance\_refresh](#input\_instance\_refresh) | Enable instance refresh in ASG | `list(any)` | `[]` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | `"t3.small"` | no |
| <a name="input_jumpbox_sg_id"></a> [jumpbox\_sg\_id](#input\_jumpbox\_sg\_id) | Jumpbox server security group id | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | EC2 SSH Key Pair name | `string` | `"default"` | no |
| <a name="input_list_of_extra_sg_ids"></a> [list\_of\_extra\_sg\_ids](#input\_list\_of\_extra\_sg\_ids) | List of extra security groups to attach to ec2 servers | `list(any)` | `[]` | no |
| <a name="input_listener_arn"></a> [listener\_arn](#input\_listener\_arn) | ALB Listener ARN | `string` | n/a | yes |
| <a name="input_managed_policy_arns_server"></a> [managed\_policy\_arns\_server](#input\_managed\_policy\_arns\_server) | List of policy arns to attach to ec2 server iam instance profile | `list(any)` | `[]` | no |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | CloudWatch alarm name | `string` | `"CPUUtilization"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Alarm namespace | `string` | `"AWS/EC2"` | no |
| <a name="input_path_pattern"></a> [path\_pattern](#input\_path\_pattern) | Path pattern for path based routing | `string` | `"*"` | no |
| <a name="input_period"></a> [period](#input\_period) | Alarm period | `string` | `"120"` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | Priority number for ALB listener rules | `number` | `100` | no |
| <a name="input_statistic"></a> [statistic](#input\_statistic) | Alarm statistic | `string` | `"Average"` | no |
| <a name="input_subnet_tag"></a> [subnet\_tag](#input\_subnet\_tag) | Tag used on subnets to define subnet type | `string` | `"subnet_type"` | no |
| <a name="input_subnet_tag_value"></a> [subnet\_tag\_value](#input\_subnet\_tag\_value) | Subnet tag value | `string` | `"public"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_target_group_port"></a> [target\_group\_port](#input\_target\_group\_port) | Target Group Port | `string` | `"80"` | no |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | Alarm threshold | `string` | `"70"` | no |
| <a name="input_trust_principals"></a> [trust\_principals](#input\_trust\_principals) | Trust Principals | `map(any)` | <pre>{<br>  "Service": "ec2.amazonaws.com"<br>}</pre> | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data for Ec2 server | `string` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC Name for the AWS account and region specified | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aurora_master_password"></a> [aurora\_master\_password](#output\_aurora\_master\_password) | The master password for  RDS server |
| <a name="output_server_sg_id"></a> [server\_sg\_id](#output\_server\_sg\_id) | n/a |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | The master password for  RDS server |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
