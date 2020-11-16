data "aws_route53_zone" "selected" {
  count = var.hostname_create ? 1 : 0
  name  = var.hosted_zone
}

resource "aws_route53_record" "alb_hostname" {
  count = var.lb_type == "ALB" && var.hostname_create && length(var.hostnames) != 0 ? length(var.hostnames) : 0

  zone_id = data.aws_route53_zone.selected.*.zone_id[0]
  name    = var.hostnames[count.index]
  type    = "CNAME"
  ttl     = "300"
  records = aws_lb.alb.*.dns_name
}

resource "aws_route53_record" "nlb_hostname" {
  count = var.lb_type == "NLB" && var.hostname_create && length(var.hostnames) != 0 ? length(var.hostnames) : 0

  zone_id = data.aws_route53_zone.selected.*.zone_id[0]
  name    = var.hostnames[count.index]
  type    = "CNAME"
  ttl     = "300"
  records = aws_lb.nlb.*.dns_name
}

resource "aws_route53_record" "eip_hostname" {
  count = var.lb_type == "EIP" && var.hostname_create && length(var.hostnames) != 0 ? length(var.hostnames) : 0

  zone_id = data.aws_route53_zone.selected.*.zone_id[0]
  name    = var.hostnames[count.index]
  type    = "A"
  ttl     = "300"
  records = aws_eip.default.*.public_ip

  depends_on = [aws_eip.default]
}