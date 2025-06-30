resource "aws_launch_template" "this" {
  name   = "${local.base_name}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = var.user_data != "" ? base64encode(var.user_data) : null

  block_device_mappings {
    device_name = var.device_name
    ebs {
      volume_size = var.volume_size
      volume_type = "gp3"
    }
  }

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups              = var.lt_sg_id != "" ? [var.lt_sg_id] : null
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      {
        Name = "${local.base_name}-instance"
      },
      local.common_tags
    )
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name                      = "${local.base_name}-asg"
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  vpc_zone_identifier       = var.subnet_ids
  target_group_arns         = var.target_group_arns
  termination_policies      = var.termination_policies

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  dynamic "initial_lifecycle_hook" {
    for_each = var.enable_lifecycle_hook ? [1] : []
    content {
      name                 = "${local.base_name}-lifecycle"
      lifecycle_transition = var.lifecycle_transition
      heartbeat_timeout    = var.heartbeat_timeout
      default_result       = var.default_result
    }
  }

  dynamic "tag" {
    for_each = merge(
      {
        Name = "${local.base_name}-asg"
      },
      local.common_tags
    )
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  count                  = var.enable_scale_up ? 1 : 0
  name                   = "${local.base_name}-scale-up"
  autoscaling_group_name = aws_autoscaling_group.this.name
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = var.scale_up_adjustment
  cooldown               = var.cooldown
}

resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  count               = var.enable_scale_up ? 1 : 0
  alarm_name          = "${local.base_name}-scale-up-alarm"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  statistic           = "Average"
  period              = var.period
  evaluation_periods  = var.evaluation_periods
  threshold           = var.cpu_threshold_up
  comparison_operator = "GreaterThanThreshold"
  alarm_description   = "Scale up on high CPU"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.name
  }
  alarm_actions = [aws_autoscaling_policy.scale_up[0].arn]

  tags = local.common_tags
}

resource "aws_autoscaling_policy" "scale_down" {
  count                  = var.enable_scale_down ? 1 : 0
  name                   = "${local.base_name}-scale-down"
  autoscaling_group_name = aws_autoscaling_group.this.name
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = var.scale_down_adjustment
  cooldown               = var.cooldown
}

resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  count               = var.enable_scale_down ? 1 : 0
  alarm_name          = "${local.base_name}-scale-down-alarm"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  statistic           = "Average"
  period              = var.period
  evaluation_periods  = var.evaluation_periods
  threshold           = var.cpu_threshold_down
  comparison_operator = "LessThanThreshold"
  alarm_description   = "Scale down on low CPU"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.name
  }
  alarm_actions = [aws_autoscaling_policy.scale_down[0].arn]

  tags = local.common_tags
}
