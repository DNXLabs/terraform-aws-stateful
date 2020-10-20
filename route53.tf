data "aws_route53_zone" "selected" {
  count = var.enable_alb && var.hostname_create ? 1 : 0
  name  = var.hosted_zone
}

resource "aws_route53_record" "hostname" {
  count = var.enable_alb && var.hostname_create && length(var.hostnames) != 0 ? length(var.hostnames) : 0

  zone_id = data.aws_route53_zone.selected.*.zone_id[0]
  name    = var.hostnames[count.index]
  type    = "CNAME"
  ttl     = "300"
  records = aws_lb.stateful.*.dns_name
}
