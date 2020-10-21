resource "aws_lb" "stateful" {
  count              = var.enable_alb ? 1 : 0
  name               = "alb-${var.name}"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids

  security_groups = [
    aws_security_group.alb[0].id,
  ]

  idle_timeout = 400

  tags = {
    Name = "stateful-${var.name}"
  }
}

resource "aws_lb_target_group" "stateful" {
  count    = var.enable_alb ? 1 : 0
  name     = "sg-${var.name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "stateful" {
  count             = var.enable_alb ? 1 : 0
  load_balancer_arn = aws_lb.stateful[0].arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.stateful[0].arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_stateful" {
  count                  = "${var.enable_alb ? 1 : 0}" * var.instance_count
  autoscaling_group_name = aws_autoscaling_group.stateful_alb[count.index].name
  alb_target_group_arn   = aws_lb_target_group.stateful[0].arn
  depends_on             = [aws_lb_target_group.stateful]
}