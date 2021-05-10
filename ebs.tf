# resource "aws_ebs_volume" "default" {
#   count = var.fs_type == "EBS" ? 1 : 0
#   availability_zone = "us-west-2a"
#   size              = 40

#   tags = {
#     Name = "HelloWorld"
#   }
# }