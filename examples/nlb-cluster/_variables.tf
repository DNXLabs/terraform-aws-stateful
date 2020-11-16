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
      instance_count = 1
      lb_type        = "NLB"
      lb_port        = 22 ## any tcp port, if you choose an UDP port, also change the lb_protocol variable below
      lb_protocol    = "TCP"
      sg_cidr_blocks = ["0.0.0.0/0"]
    }
  }

  workspace = local.env[terraform.workspace]

}