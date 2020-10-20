module "alb_stateful" {
  source             = "git@github.com:DNXLabs/terraform-aws-stateful.git"
  name               = "${local.workspace["name"]}-${local.workspace["account_name"]}"
  instance_type      = local.workspace["instance_type"]
  instance_count     = local.workspace["instance_count"]
  vpc_id             = data.aws_vpc.selected.id
  private_subnet_ids = data.aws_subnet_ids.private.ids
  public_subnet_ids  = data.aws_subnet_ids.public.ids
  secure_subnet_ids  = data.aws_subnet_ids.secure.ids
  enable_alb         = true
  hostname_create    = true
  hostnames          = local.workspace["hostnames"]
  hosted_zone        = local.workspace["hosted_zone"]
  certificate_arn    = data.aws_acm_certificate.domain_host.arn
  custom_efs_dir     = local.workspace["custom_efs_dir"]
}