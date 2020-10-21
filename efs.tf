resource "aws_efs_file_system" "stateful" {
  creation_token = "stateful-${var.name}"
  encrypted      = true

  tags = {
    Name = "stateful-${var.name}"
  }

}

resource "aws_efs_mount_target" "stateful" {
  count          = length(var.secure_subnet_ids)
  file_system_id = aws_efs_file_system.stateful.id
  subnet_id      = var.secure_subnet_ids[count.index]

  security_groups = [
    aws_security_group.efs.id,
  ]

  lifecycle {
    ignore_changes = [subnet_id]
  }
}

resource "aws_security_group" "efs" {
  name        = "stateful-efs-${var.name}"
  description = "for EFS to talk to stateful cluster"
  vpc_id      = var.vpc_id

  tags = {
    Name = "stateful-efs-${var.name}"
  }
}

resource "aws_security_group_rule" "nfs_from_stateful_to_efs" {
  description              = "stateful to EFS"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.efs.id
  source_security_group_id = aws_security_group.stateful.id
}
