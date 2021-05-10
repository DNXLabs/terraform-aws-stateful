resource "aws_security_group_rule" "nlb_access_tcp" {
  count = var.lb_type == "NLB" ? length(var.tcp_ports) : 0

  description       = "TCP/${var.tcp_ports[count.index]} access"
  type              = "ingress"
  from_port         = var.tcp_ports[count.index]
  to_port           = var.tcp_ports[count.index]
  protocol          = "TCP"
  security_group_id = aws_security_group.default.id
  cidr_blocks       = [data.aws_vpc.current.cidr_block]
}

resource "aws_security_group_rule" "nlb_access_udp" {
  count = var.lb_type == "NLB" ? length(var.udp_ports) : 0

  description       = "UDP/${var.udp_ports[count.index]} access"
  type              = "ingress"
  from_port         = var.udp_ports[count.index]
  to_port           = var.udp_ports[count.index]
  protocol          = "UDP"
  security_group_id = aws_security_group.default.id
  cidr_blocks       = [data.aws_vpc.current.cidr_block]
}
