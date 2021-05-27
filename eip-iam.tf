resource "aws_iam_policy" "default_eip" {
  count = var.lb_type == "EIP" ? 1 : 0

  name        = var.name
  path        = "/"
  description = "Policy for EC2 instances"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:AssociateAddress",
        "ec2:DisassociateAddress",
        "ec2:DescribeAddresses"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "default_extra" {
  count = var.lb_type == "EIP" ? 1 : 0

  role       = aws_iam_role.default.name
  policy_arn = aws_iam_policy.default_eip[0].arn
}