resource "aws_eip" "default" {
  count = var.lb_type == "EIP" ? 1 : 0
  vpc   = true

  tags = {
    Name = var.name
  }
}