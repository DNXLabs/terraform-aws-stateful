resource "aws_lb" "nlb" {
  count              = var.lb_type == "NLB" ? 1 : 0
  name               = "nlb-${var.name}"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_lb_target_group" "nlb_tg" {
  count    = var.lb_type == "NLB" ? 1 : 0
  name     = "tg-${var.name}"
  port     = var.lb_port
  protocol = var.lb_protocol
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "nlb_listener" {
  count             = var.lb_type == "NLB" ? 1 : 0
  load_balancer_arn = aws_lb.nlb[0].arn
  port              = var.lb_port
  protocol          = var.lb_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg[0].arn
  }
}

resource "aws_autoscaling_attachment" "nlb_asg_attachment" {
  count                  = "${var.lb_type == "NLB" ? 1 : 0}" * var.instance_count
  autoscaling_group_name = aws_autoscaling_group.asg[count.index].name
  alb_target_group_arn   = aws_lb_target_group.nlb_tg[0].arn
  depends_on             = [aws_lb_target_group.nlb_tg]
}