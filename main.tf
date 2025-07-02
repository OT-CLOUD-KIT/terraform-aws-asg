# -------------------------
# module/launch_template/main.tf
# -------------------------
resource "aws_launch_template" "this" {
  name_prefix   = "${local.base_name}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = var.user_data != "" ? base64encode(var.user_data) : null

  block_device_mappings {
    device_name = var.device_name
    ebs {
      volume_size           = var.volume_size
      volume_type           = var.volume_type
      delete_on_termination = var.ebs_delete_on_termination
    }
  }

  dynamic "capacity_reservation_specification" {
    for_each = var.enable_capacity_reservation ? [1] : []
    content {
      capacity_reservation_preference = var.capacity_reservation_preference
    }
  }

  dynamic "cpu_options" {
    for_each = var.enable_cpu_options ? [1] : []
    content {
      core_count       = var.cpu_core_count
      threads_per_core = var.cpu_threads_per_core
    }
  }

  dynamic "credit_specification" {
    for_each = var.enable_credit_specification ? [1] : []
    content {
      cpu_credits = var.cpu_credits
    }
  }

  disable_api_stop        = var.disable_api_stop
  disable_api_termination = var.disable_api_termination
  ebs_optimized           = var.ebs_optimized

  dynamic "iam_instance_profile" {
    for_each = var.iam_instance_profile_name != "" ? [1] : []
    content {
      name = var.iam_instance_profile_name
    }
  }

  instance_initiated_shutdown_behavior = var.shutdown_behavior

  dynamic "instance_market_options" {
    for_each = var.enable_spot_instance ? [1] : []
    content {
      market_type = "spot"
    }
  }

  dynamic "license_specification" {
    for_each = var.license_arn != "" ? [1] : []
    content {
      license_configuration_arn = var.license_arn
    }
  }

  metadata_options {
    http_endpoint               = var.metadata_http_endpoint
    http_tokens                 = var.metadata_http_tokens
    http_put_response_hop_limit = var.metadata_hop_limit
    instance_metadata_tags      = var.metadata_tags
  }

  monitoring {
    enabled = var.monitoring_enabled
  }

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups              = var.lt_sg_id != "" ? [var.lt_sg_id] : null
  }

  dynamic "placement" {
    for_each = var.availability_zone != "" ? [1] : []
    content {
      availability_zone = var.availability_zone
    }
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

# -------------------------
# module/autoscaling_group/main.tf
# -------------------------
resource "aws_autoscaling_group" "this" {
  name                      = "${local.base_name}-asg"
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  vpc_zone_identifier       = var.subnet_ids
  # target_group_arns         = var.target_group_arns
  target_group_arns = var.target_group_arns != "" ? [var.target_group_arns] : null

  termination_policies      = var.termination_policies

  dynamic "launch_template" {
    for_each = var.enable_mixed_instances ? [] : [1]
    content {
      id      = aws_launch_template.this.id
      version = "$Latest"
    }
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

  dynamic "instance_maintenance_policy" {
    for_each = var.enable_instance_maintenance_policy ? [1] : []
    content {
      min_healthy_percentage = var.min_healthy_percentage
      max_healthy_percentage = var.max_healthy_percentage
    }
  }

  dynamic "mixed_instances_policy" {
    for_each = var.enable_mixed_instances ? [1] : []
    content {
      instances_distribution {
        on_demand_allocation_strategy            = var.on_demand_allocation_strategy
        on_demand_base_capacity                  = var.on_demand_base_capacity
        on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
        spot_allocation_strategy                 = var.spot_allocation_strategy
      }

      launch_template {
        launch_template_specification {
          launch_template_id = aws_launch_template.this.id
          version            = "$Latest"
        }

        dynamic "override" {
          for_each = var.instance_type_overrides
          content {
            instance_type = override.value
          }
        }
      }
    }
  }

  dynamic "tag" {
    for_each = merge({ Name = "${local.base_name}-asg" }, local.common_tags)
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }


  lifecycle {
    create_before_destroy = true
  }


 
}

# -------------------------
# module/autoscaling_group/policies.tf
# -------------------------
resource "aws_autoscaling_policy" "target_tracking_cpu" {
  count                  = var.enable_target_tracking ? 1 : 0
  name                   = "${local.base_name}-cpu-tracking"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.this.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value     = var.cpu_target_value
    disable_scale_in = false
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
  tags          = local.common_tags
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
  tags          = local.common_tags
}
