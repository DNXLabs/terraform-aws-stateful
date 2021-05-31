resource "aws_autoscaling_group" "asg" {
  count               = var.instance_count
  name                = "${var.name}-${count.index}"
  min_size            = 1
  max_size            = 1
  vpc_zone_identifier = list(var.instances_subnet_ids[count.index])

   mixed_instances_policy { 

    launch_template {
      launch_template_specification {
        launch_template_name = aws_launch_template.default.name
        version = "$Latest"
      }
    }
    instances_distribution {
    
      on_demand_base_capacity                  = var.on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.on_demand_percentage
    }

}

  tags = concat(
    [ for key, value in var.tags: { key: key, value: value, propagate_at_launch: true } ],
    [{
      key   = "Name"
      value = var.name
      propagate_at_launch = true
    }]
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [load_balancers, target_group_arns]
  }
}