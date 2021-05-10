resource "aws_autoscaling_group" "asg" {
  count               = var.instance_count
  name                = "${var.name}-${count.index}"
  min_size            = 1
  max_size            = 1
  vpc_zone_identifier = list(var.instances_subnet_ids[count.index])

  launch_template {
    name    = aws_launch_template.default.name
    version = "$Latest"
  }

  tags = [
    map("key", "Name", "value", var.name, "propagate_at_launch", true)
  ]

  lifecycle {
    create_before_destroy = true
  }
}