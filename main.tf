resource "aws_launch_template" "lt" {
  name = var.launch_template_name
  block_device_mappings {
    device_name = var.volume_name
    ebs {
      volume_size = var.ec2_root_volume_size
    }
  }

  key_name               = var.key_name
  instance_type          = var.instance_type
  image_id               = var.image_id
  user_data              = var.user_data
  placement {
    tenancy = "default"
  }
  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = var.security_groups
  }
  monitoring {
    enabled = true
  }
  iam_instance_profile {
    name = var.iam_role_name
  }
  tag_specifications {
    resource_type = "instance"
    tags = merge(
    {
      Name = format("%s", var.launch_template_name)
    },
      var.tags
    )
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(
    {
      Name = format("%s", var.launch_template_name)
    },
      var.tags
    )
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
  {
    Name = format("%s", var.launch_template_name)
  },
    var.tags
  )
}

resource "aws_autoscaling_group" "asg" {
  name                = var.asg_name
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.lt.id
    version = aws_launch_template.lt.latest_version
  }

  dynamic "instance_refresh" {
    for_each = var.instance_refresh
    content {
      strategy = "Rolling"

      preferences {
        min_healthy_percentage = 50
      }
    }
  }

  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_capacity
  max_size                  = var.asg_max_size
  force_delete              = false
  health_check_grace_period = var.asg_health_check_grace_period
  health_check_type         = var.health_check_type

  target_group_arns = var.target_group_arns

  tag {
    key                 = "Name"
    value               = format("%s", var.asg_name)
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_policy" "asg_scale_up_policy" {
  count                  = var.enable_scaling_policy ? 1 : 0
  name                   = "${var.asg_name}-scaleup-policy"
  scaling_adjustment     = 1
  adjustment_type        = var.adjustment_type
  cooldown               = var.cooldown_period
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_cloudwatch_metric_alarm" "foobar" {
  count               = var.enable_scaling_policy ? 1 : 0
  alarm_name          = "${var.alarm_name}-high-cpu"
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_description   = "This metric monitors ${var.namespace} ${var.metric_name}"
  alarm_actions       = [aws_autoscaling_policy.asg_scale_up_policy[count.index].arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
}
