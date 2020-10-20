resource "aws_autoscaling_group" "stateful_alb" {
  count = var.instance_count
  name  = "${var.name}-${count.index}"

  min_size = 1
  max_size = 1

  vpc_zone_identifier = var.instances_subnet

  launch_template {
    name    = aws_launch_template.stateful.name
    version = "$Latest"
  }

  tags = [
    map("key", "Name", "value", "${var.name}", "propagate_at_launch", true)
  ]

  lifecycle {
    create_before_destroy = true
  }
}