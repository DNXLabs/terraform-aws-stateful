data "aws_region" "current" {}

data "aws_default_tags" "current" {}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_vpc" "current" {
  id = var.vpc_id
}

data "aws_subnet" "instances" {
  count = length(var.instances_subnet_ids)
  id    = var.instances_subnet_ids[count.index]
}