data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${local.workspace["cluster_name"]}-VPC"]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "tag:Scheme"
    values = ["public"]
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "tag:Scheme"
    values = ["private"]
  }
}

data "aws_subnet_ids" "secure" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "tag:Scheme"
    values = ["secure"]
  }
}

data "aws_acm_certificate" "domain_host" {
  domain   = "*.hosted.zone"
  statuses = ["ISSUED"]
}

data "aws_route53_zone" "selected" {
  name  = local.workspace["hosted_zone"]
}

data "aws_region" "current" {}