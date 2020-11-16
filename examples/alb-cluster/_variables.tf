variable "aws_account_id" {}
variable "aws_role" {}

locals {
  env = {
    labs-ap-southeast-2-dev = {
      cluster_name   = "labs2"
      region         = "ap-southeast-2"
      instance_type  = "t2.micro"
      name           = "app-name"
      hosted_zone    = "hosted.zone"
      hostnames      = ["mydomain.hosted.zone"]
      custom_efs_dir = "/my-dir"
      instance_count = 3
      lb_type        = "ALB"
    }
  }

  workspace = local.env[terraform.workspace]

}