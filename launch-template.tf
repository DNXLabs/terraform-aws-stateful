data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")

  vars = {
    custom_efs_dir = var.custom_efs_dir
    tf_efs_id      = aws_efs_file_system.stateful.id
    userdata_extra = var.userdata
  }
}

resource "aws_launch_template" "stateful" {
  name_prefix   = "stateful-${var.name}-"
  image_id      = data.aws_ami.amazon-linux-2.image_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.stateful.name
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.instance_volume_size_root
    }
  }

  key_name = aws_key_pair.stateful.id

  vpc_security_group_ids = concat(list(aws_security_group.stateful.id), var.security_group_ids)

  user_data = base64encode(data.template_file.userdata.rendered)

  lifecycle {
    create_before_destroy = true
  }
}

resource "tls_private_key" "stateful" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "stateful" {
  key_name   = var.name
  public_key = tls_private_key.stateful.public_key_openssh
}

resource "aws_ssm_parameter" "stateful_private_key" {
  name  = "/stateful/${var.name}/PRIVATE_KEY"
  type  = "SecureString"
  value = tls_private_key.stateful.private_key_pem
  lifecycle {
    ignore_changes = [value]
  }
}