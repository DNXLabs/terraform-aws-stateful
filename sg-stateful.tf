resource "aws_security_group" "stateful" {
  name        = "stateful-${var.name}"
  description = "SG for stateful"
  vpc_id      = var.vpc_id

  tags = {
    Name = "stateful-${var.name}"
  }
}

resource "aws_security_group_rule" "all_from_alb_to_stateful" {
  count = var.enable_alb ? 1 : 0

  description              = "from ALB"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.stateful.id
  source_security_group_id = aws_security_group.alb[0].id
}

resource "aws_security_group_rule" "all_from_stateful_to_stateful" {
  description              = "Traffic between stateful "
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.stateful.id
  source_security_group_id = aws_security_group.stateful.id
}

resource "aws_security_group_rule" "all_from_stateful_world" {
  description       = "Traffic to internet"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.stateful.id
  cidr_blocks       = ["0.0.0.0/0"]
}