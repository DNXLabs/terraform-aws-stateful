resource "aws_security_group" "default" {
  name        = var.name
  description = "SG for ${var.name}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_custom_ingress_rules
    content {
      description     = ingress.value.description
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = try(ingress.value.cidr_blocks, null)
      security_groups = try(ingress.value.security_groups, null)
    }
  }

  dynamic "egress" {
    for_each = var.sg_custom_egress_rules
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = var.name
  }
}

resource "aws_security_group_rule" "default_ingress" {
  description              = "Traffic between ${var.name}"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.default.id
  source_security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "default_egress" {
  description       = "Traffic to internet"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.default.id
  cidr_blocks       = ["0.0.0.0/0"]
}
