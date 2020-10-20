resource "aws_iam_instance_profile" "stateful" {
  name = "stateful-${var.name}-${data.aws_region.current.name}"
  role = aws_iam_role.stateful.name
}

resource "aws_iam_role" "stateful" {
  name = "stateful-${var.name}-${data.aws_region.current.name}"

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
}

resource "aws_iam_role_policy_attachment" "stateful_ssm" {
  role       = aws_iam_role.stateful.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}