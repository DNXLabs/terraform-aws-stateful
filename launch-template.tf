locals {
  userdata = templatefile("${path.module}/userdata.tpl",
    {
      userdata_extra = var.userdata
      eip            = var.lb_type == "EIP" ? local.template_eip : ""
      efs            = var.fs_type == "EFS" ? local.template_efs : ""
      ebs            = var.fs_type == "EBS" ? local.template_ebs : ""
      cwlogs         = length(var.cwlog_files) > 0 ? local.template_cwlogs : ""
    }
  )
  template_eip = templatefile("${path.module}/userdata-eip.tpl",
    {
      region = data.aws_region.current.id,
      eip_id = tostring(try(aws_eip.default[0].id, ""))
    }
  )
  template_efs = templatefile("${path.module}/userdata-efs.tpl",
    {
      efs_mount_dir = var.efs_mount_dir
      efs_id        = try(aws_efs_file_system.default[0].id, "")
    }
  )
  template_ebs = templatefile("${path.module}/userdata-ebs.tpl",
    {
      ebs_mount_dir = var.ebs_mount_dir
      ebs_id        = try(aws_ebs_volume.default[0].id, "")
    }
  )
  template_cwlogs = templatefile("${path.module}/userdata-cwlogs.tpl",
    {
      log_files = var.cwlog_files
      name      = var.name
    }
  )
}

resource "aws_launch_template" "default" {
  name_prefix            = var.name
  image_id               = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon-linux-2.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = concat([aws_security_group.default.id], var.security_group_ids)
  user_data              = base64encode(local.userdata)
  key_name               = aws_key_pair.default.id

  iam_instance_profile {
    arn = aws_iam_instance_profile.default.arn
  }

  dynamic "block_device_mappings" {
    for_each = var.ebs_root_size > 0 ? [1] : []
    content {
      device_name = "/dev/sda1"

      ebs {
        volume_size           = var.ebs_root_size
        delete_on_termination = true
        volume_type           = "gp2"
        encrypted             = false
      }
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.name
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "default" {
  key_name   = var.name
  public_key = tls_private_key.default.public_key_openssh
}

resource "aws_ssm_parameter" "default_private_key" {
  name  = "/ec2/${var.name}/PRIVATE_KEY"
  type  = "SecureString"
  value = tls_private_key.default.private_key_pem
  lifecycle {
    ignore_changes = [value]
  }
}
