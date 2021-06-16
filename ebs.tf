resource "aws_ebs_volume" "default" {
  count = var.fs_type == "EBS" ? length(var.instances_subnet_ids) : 0
  availability_zone = data.aws_subnet.instances[count.index].availability_zone
  size              = var.ebs_size
  encrypted         = var.ebs_encrypted
  kms_key_id        = var.ebs_kms_key_id
  type              = var.ebs_type

  tags = {
    Name = var.name
  }
}