resource "aws_security_group" "alb" {
  count = var.enable_alb ? 1 : 0

  name        = "stateful-lb-${var.name}"
  description = "SG for stateful ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "stateful-lb-${var.name}"
  }
}

resource "aws_security_group_rule" "http_from_world_to_alb" {
  count = var.enable_alb ? 1 : 0

  description       = "HTTP Redirect stateful ALB"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb[0].id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https_from_world_to_alb" {
  count = var.enable_alb ? 1 : 0

  description       = "HTTPS stateful ALB"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb[0].id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "to_stateful_nodes" {
  count = var.enable_alb ? 1 : 0

  description              = "Traffic to stateful Nodes"
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.alb[0].id
  source_security_group_id = aws_security_group.stateful.id
}