resource "aws_iam_instance_profile" "default" {
  name = "${var.name}-${data.aws_region.current.name}"
  role = aws_iam_role.default.name
}

resource "aws_iam_role" "default" {
  name = "${var.name}-${data.aws_region.current.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  inline_policy {
    name = "ebs-attach-volume"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["ec2:AttachVolume", "ec2:DetachVolume"]
          Effect   = "Allow"
          Resource = compact([try(aws_ebs_volume.default[0].arn, ""), "arn:aws:ec2:*:*:instance/*"])
        },
      ]
    })
  }
}

resource "aws_iam_role_policy_attachment" "default_ssm" {
  role       = aws_iam_role.default.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}