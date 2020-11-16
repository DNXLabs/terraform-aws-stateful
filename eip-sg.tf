resource "aws_security_group_rule" "eip_access" {
  count = var.lb_type == "EIP" ? 1 : 0

  description       = "${var.lb_port} access"
  type              = "ingress"
  from_port         = var.lb_port
  to_port           = var.lb_port
  protocol          = var.lb_protocol
  security_group_id = aws_security_group.default.id
  cidr_blocks       = var.sg_cidr_blocks
  depends_on        = [aws_security_group.default]
}
