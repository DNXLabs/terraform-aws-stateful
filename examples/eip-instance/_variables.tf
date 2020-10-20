variable "aws_account_id" {}
variable "aws_role" {}

locals {
  env = {
    labs-ap-southeast-2-dev = {
      account_name  = "dev"
      region        = "ap-southeast-2"
      instance_type = "t2.micro"
      name          = "app-name"
      hosted_zone   = "hosted.zone"
      hostnames     = [ "mydomain.hosted.zone" ]
      custom_efs_dir = "/home"
      instance_count = 1
    }
  }

  workspace = local.env[terraform.workspace]
}
