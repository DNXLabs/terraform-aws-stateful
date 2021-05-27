module "alb_cluster" {
  source               = "./modules/terraform-aws-stateful/"
  name                 = local.workspace["name"]
  instance_type        = local.workspace["instance_type"]
  instance_count       = local.workspace["instance_count"]
  efs_mount_dir        = local.workspace["efs_mount_dir"]
  hostnames            = local.workspace["hostnames"]
  hosted_zone          = local.workspace["hosted_zone"]
  lb_type              = local.workspace["lb_type"]
  hostname_create      = true
  vpc_id               = data.aws_vpc.selected.id
  instances_subnet_ids = data.aws_subnet_ids.private.ids
  efs_subnet_ids       = data.aws_subnet_ids.secure.ids
  lb_subnet_ids        = data.aws_subnet_ids.public.ids
}