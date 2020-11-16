resource "aws_security_group" "alb" {
  count = var.lb_type == "ALB" ? 1 : 0

  name        = "${var.name}-lb"
  description = "SG for ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name}-lb"
  }
}

resource "aws_security_group_rule" "http_from_world_to_alb" {
  count = var.lb_type == "ALB" ? 1 : 0

  description       = "HTTP Redirect ${var.name} ALB"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb[0].id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https_from_world_to_alb" {
  count = var.lb_type == "ALB" ? 1 : 0

  description       = "HTTPS ${var.name} ALB"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb[0].id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_to_nodes" {
  count = var.lb_type == "ALB" ? 1 : 0

  description              = "Traffic to ${var.name} Nodes"
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.alb[0].id
  source_security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "from_alb_to_nodes" {
  count = var.lb_type == "ALB" ? 1 : 0

  description              = "from ALB"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.default.id
  source_security_group_id = aws_security_group.alb[0].id

  depends_on = [aws_security_group.default]
}