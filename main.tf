resource "aws_iam_role" "asg_server_iam_role" {
  name = "${var.env}-asg-server-role"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "s3-policy-attach" {
  role       = aws_iam_role.asg_server_iam_role.name
  policy_arn = data.aws_iam_policy.s3_fullaccess.arn
}

resource "aws_iam_instance_profile" "asg_server_iam_role_profile" {
  #name = "${var.env}-asg-server-role"
  role = aws_iam_role.asg_server_iam_role.name
}


# Launch Templates of Applications
####launch Template Creation
resource "aws_launch_template" "Application" {
  name_prefix   = var.name_template
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data = base64encode(templatefile(var.userdata, {
    s3_bucket_name                    = var.s3_bucket_name,
    s3_remote_path                    = var.s3_remote_path,
    s3_artifact_version               = var.s3_artifact_version,
    s3_artifact_zip                   = var.s3_artifact_zip,
    local_destination                 = var.local_destination,
    s3_artifact_folder_name           = var.s3_artifact_folder_name
    remote_server_app_deployment_path = var.remote_server_app_deployment_path
  }))
  iam_instance_profile {
    name = aws_iam_instance_profile.asg_server_iam_role_profile.arn
  }
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
  target_group_arns         = var.target_group_arns
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_size
  vpc_zone_identifier       = var.vpc_zone_identifier_subnet
}

resource "aws_autoscaling_policy" "scale_up" {
  count                  = var.enable_cpu_based_autoscaling ? 1 : 0
  name                   = "${var.name}-asg-scale-up"
  policy_type            = var.policy_type_scale_up
  autoscaling_group_name = aws_autoscaling_group.Application.name
  target_tracking_configuration {
    target_value     = var.cpu_threshold_up
    disable_scale_in = var.disable_scale_in

    customized_metric_specification {
      metric_name = "CPUReservation"
      namespace   = "AWS/EC2"
      statistic   = var.cpu_statistics
    }
  }
  lifecycle {
    create_before_destroy = true
  }
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
  policy_type            = var.policy_type_scale_down
  target_tracking_configuration {
    target_value     = var.cpu_threshold_down
    disable_scale_in = var.disable_scale_down

    customized_metric_specification {
      metric_name = "CPUReservation"
      namespace   = "AWS/EC2"
      statistic   = var.cpu_statistics
    }
  }
  lifecycle {
    create_before_destroy = true
  }
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
