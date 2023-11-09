variable "aws_account_id" {}
variable "aws_role" {}

locals {
  env = {
    labs-ap-southeast-2-dev = {
      environment_name = "labs2"
      region           = "ap-southeast-2"
      instance_type    = "t2.micro"
      name             = "app-name"
      hosted_zone      = "hosted.zone"
      hostnames        = ["mydomain.hosted.zone"]
      efs_mount_dir    = "/my-dir"
      instance_count   = 1
      lb_type          = "EIP"
      tcp_ports        = [22]
      sg_cidr_blocks   = ["0.0.0.0/0"]
    }
  }

  workspace = local.env[terraform.workspace]

}