resource "aws_lb" "alb" {
  count              = var.lb_type == "ALB" ? 1 : 0
  name               = "alb-${var.name}"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids

  security_groups = [
    aws_security_group.alb[0].id,
  ]

  idle_timeout = 400

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  count    = var.lb_type == "ALB" ? 1 : 0
  name     = "tg-${var.name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "alb_http_listener" {
  count             = var.lb_type == "ALB" ? 1 : 0
  load_balancer_arn = aws_lb.alb[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "alb_https_listener" {
  count             = var.lb_type == "ALB" ? 1 : 0
  load_balancer_arn = aws_lb.alb[0].arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg[0].arn
  }
}

resource "aws_autoscaling_attachment" "alb_asg_attachment" {
  count                  = "${var.lb_type == "ALB" ? 1 : 0}" * var.instance_count
  autoscaling_group_name = aws_autoscaling_group.asg[count.index].name
  alb_target_group_arn   = aws_lb_target_group.alb_tg[0].arn
  depends_on             = [aws_lb_target_group.alb_tg]
}