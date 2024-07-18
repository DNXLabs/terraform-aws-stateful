resource "aws_eip" "default" {
  count  = var.lb_type == "EIP" ? 1 : 0
  domain = "vpc"

  tags = {
    Name = var.name
  }
}
