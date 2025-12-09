resource "aws_autoscaling_schedule" "scale_down" {
  count                  = var.enable_schedule ? var.instance_count : 0
  scheduled_action_name  = "${var.name}-${count.index}-stop"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = var.schedule_cron_stop
  autoscaling_group_name = aws_autoscaling_group.asg[count.index].name
}

resource "aws_autoscaling_schedule" "scale_up" {
  count                  = var.enable_schedule ? var.instance_count : 0
  scheduled_action_name  = "${var.name}-${count.index}-start"
  min_size               = 1
  max_size               = 1
  desired_capacity       = 1
  recurrence             = var.schedule_cron_start
  autoscaling_group_name = aws_autoscaling_group.asg[count.index].name
}
