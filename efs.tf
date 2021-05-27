resource "aws_efs_file_system" "default" {
  count          = var.fs_type == "EFS" && length(var.efs_subnet_ids) > 0 ? 1 : 0
  creation_token = var.name
  encrypted      = true

  tags = {
    Name = "efs-${var.name}"
  }
}

resource "aws_efs_mount_target" "default" {
  count          = var.fs_type == "EFS" ? length(var.efs_subnet_ids) : 0
  file_system_id = aws_efs_file_system.default[0].id
  subnet_id      = var.efs_subnet_ids[count.index]

  security_groups = [
    aws_security_group.efs[0].id,
  ]

  lifecycle {
    ignore_changes = [subnet_id]
  }
}

resource "aws_security_group" "efs" {
  count       = var.fs_type == "EFS" && length(var.efs_subnet_ids) > 0 ? 1 : 0
  name        = "efs-${var.name}"
  description = "for EFS to talk to default cluster"
  vpc_id      = var.vpc_id

  tags = {
    Name = "efs-${var.name}"
  }
}

resource "aws_security_group_rule" "nfs_from_node_to_efs" {
  count                    = var.fs_type == "EFS" && length(var.efs_subnet_ids) > 0 ? 1 : 0
  description              = "${var.name} to EFS"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.efs[0].id
  source_security_group_id = aws_security_group.default.id
}
