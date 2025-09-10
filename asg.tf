locals {
  all_tags = merge(
    data.aws_default_tags.current.tags,
    var.tags
  )
}

resource "aws_autoscaling_group" "asg" {
  count               = var.instance_count
  name                = "${var.name}-${count.index}"
  min_size            = 1
  max_size            = 1
  vpc_zone_identifier = [var.instances_subnet_ids[count.index]]

  mixed_instances_policy {

    launch_template {
      launch_template_specification {
        launch_template_id = var.launch_template_id != "" ? var.launch_template_id : aws_launch_template.default.id
        version            = "$Latest"
      }
      override {
        instance_type = var.instance_type
        launch_template_specification {
          launch_template_id = var.launch_template_id != "" ? var.launch_template_id : aws_launch_template.default.id
        }
      }
    }
    instances_distribution {

      on_demand_base_capacity                  = var.on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.on_demand_percentage
    }

  }

  dynamic "tag" {
    for_each = local.all_tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  
  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [load_balancers, target_group_arns]
  }
}
