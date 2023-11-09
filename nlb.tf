resource "aws_lb" "nlb" {
  count              = var.lb_type == "NLB" ? 1 : 0
  name               = "nlb-${var.name}"
  internal           = var.lb_scheme == "internal" ? true : false
  load_balancer_type = "network"
  subnets            = var.lb_subnet_ids

  tags = {
    Name = var.name
  }
}

resource "aws_lb_target_group" "nlb_tg_udp" {
  count    = var.lb_type == "NLB" ? length(var.udp_ports) : 0
  name     = "tg-${var.name}-udp-${var.udp_ports[count.index]}"
  port     = var.udp_ports[count.index]
  protocol = "UDP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "nlb_tg_tcp" {
  count    = var.lb_type == "NLB" ? length(var.tcp_ports) : 0
  name     = "tg-${var.name}-tcp-${var.tcp_ports[count.index]}"
  port     = var.tcp_ports[count.index]
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "nlb_listener_udp" {
  count             = var.lb_type == "NLB" ? length(var.udp_ports) : 0
  load_balancer_arn = aws_lb.nlb[0].arn
  port              = var.udp_ports[count.index]
  protocol          = "UDP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg_udp[count.index].arn
  }
}

resource "aws_lb_listener" "nlb_listener_tcp" {
  count             = var.lb_type == "NLB" ? length(var.tcp_ports) : 0
  load_balancer_arn = aws_lb.nlb[0].arn
  port              = var.tcp_ports[count.index]
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg_tcp[count.index].arn
  }
}

resource "aws_autoscaling_attachment" "nlb_asg_attachment_udp" {
  count                  = var.lb_type == "NLB" ? (length(aws_autoscaling_group.asg) * length(var.udp_ports)) : 0
  autoscaling_group_name = aws_autoscaling_group.asg[floor(count.index / length(var.udp_ports))].name
  lb_target_group_arn    = aws_lb_target_group.nlb_tg_udp[count.index % length(var.udp_ports)].arn
}

resource "aws_autoscaling_attachment" "nlb_asg_attachment_tcp" {
  count                  = var.lb_type == "NLB" ? (length(aws_autoscaling_group.asg) * length(var.tcp_ports)) : 0
  autoscaling_group_name = aws_autoscaling_group.asg[floor(count.index / length(var.tcp_ports))].name
  lb_target_group_arn    = aws_lb_target_group.nlb_tg_tcp[count.index % length(var.tcp_ports)].arn
}