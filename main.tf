# Launch Templates of Applications
####launch Template Creation
resource "aws_launch_template" "Application" {
  name_prefix   = var.name_template
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = filebase64(var.user_data)


  block_device_mappings {
    device_name = var.device_name

    ebs {
      volume_size = var.volume_size
    }
  }

  network_interfaces {
    security_groups             = [var.security_group]
    associate_public_ip_address = var.associate_public_ip_address
  }
  tag_specifications {
    resource_type = "instance"
    tags          = var.server_name
  }
  tags = merge(
    var.comman_tags,
    var.template_tags
  )
}

resource "aws_autoscaling_group" "Application" {
  name = var.name
  launch_template {
    id      = aws_launch_template.Application.id
    version = var.template_version
  }
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_size
  vpc_zone_identifier       = [var.vpc_zone_identifier_subnet, var.vpc_zone_identifier_subnet2]

  initial_lifecycle_hook {
    name                 = var.name
    default_result       = var.default_result
    heartbeat_timeout    = var.heartbeat_timeout
    lifecycle_transition = var.lifecycle_transition
  }

resource "aws_autoscaling_policy" "scale_up" {
  count                  = var.create_scale_up_policy ? 1 : 0
  name                   = "${var.name}-asg-scale-up"
  policy_type            = var.policy_type_scale_up
  adjustment_type        = var.adjustment_type
  autoscaling_group_name = aws_autoscaling_group.Application.name
  cooldown               = var.cooldown
  scaling_adjustment     = var.scaling_up_adjustment
}

resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  count               = var.create_scale_up_alarm ? 1 : 0
  alarm_name          = "${var.name}-asg-scale-up-alarm"
  alarm_description   = var.alarm_description
  comparison_operator = var.comparison_operator_scale_up
  evaluation_periods  = var.scale_up_evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.scale_up_threshold
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.Application.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_up[count.index].arn]
  tags = merge(
    var.comman_tags,
    var.cloudwatch_alarm_tags
  )
}

# scale down policy
resource "aws_autoscaling_policy" "scale_down" {
  count                  = var.create_scale_down_policy ? 1 : 0
  name                   = "${var.name}-asg-scale-down"
  autoscaling_group_name = aws_autoscaling_group.Application.name
  adjustment_type        = var.adjustment_type
  scaling_adjustment     = var.scale_down_adjustment
  cooldown               = var.cooldown
  policy_type            = var.policy_type_scale_down
}

# scale down alarm
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  count               = var.create_scale_down_alarm ? 1 : 0
  alarm_name          = "${var.name}-asg-scale-down-alarm"
  alarm_description   = var.alarm_description_scale_down
  comparison_operator = var.comparison_operator_scale_down
  evaluation_periods  = var.scale_down_evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.scale_down_threshold
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.Application.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_down[count.index].arn]
  tags = merge(
    var.comman_tags,
    var.cloudwatch_alarm_tags
  )
}
