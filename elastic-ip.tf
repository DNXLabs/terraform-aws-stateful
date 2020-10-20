resource "aws_eip" "lb" {
  count    = var.elastic_ip ? 1 : 0
  instance = aws_instance.default.id
  vpc      = true
}