resource "aws_autoscaling_group" "asg" {
  count = var.instance_count
  name  = "${var.name}-${var.cluster_name}-${count.index}"

  min_size = 1
  max_size = 1

  vpc_zone_identifier = var.instances_subnet

  launch_template {
    name    = aws_launch_template.default.name
    version = "$Latest"
  }

  tags = [
    map("key", "Name", "value", "${var.name}", "propagate_at_launch", true)
  ]

  lifecycle {
    create_before_destroy = true
  }

  instances_distribution {
      spot_instance_pools                      = 3
      on_demand_base_capacity                  = var.on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.on_demand_percentage
    }

  depends_on = [aws_efs_file_system.default]
}