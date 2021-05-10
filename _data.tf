data "aws_region" "current" {}

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

# data "aws_subnet" "current" {
#   for_each = var.instances_subnet_ids
#   id       = each.value
# }