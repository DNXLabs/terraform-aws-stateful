resource "aws_route53_record" "stateful" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = local.workspace["hostnames"]
  type    = "A"
  ttl     = "300"
  records = [aws_eip.stateful.public_ip]
}

module "eip_stateful" {
  source             = "./modules/terraform-aws-stateful/"
  name               = "${local.workspace["name"]}-${local.workspace["account_name"]}"
  instance_type      = local.workspace["instance_type"]
  instance_count     = local.workspace["instance_count"]
  vpc_id             = data.aws_vpc.selected.id
  instances_subnet   = data.aws_subnet_ids.public.ids
  private_subnet_ids = data.aws_subnet_ids.private.ids
  secure_subnet_ids  = data.aws_subnet_ids.secure.ids
  security_group_ids = [aws_security_group.stateful.id]
  hostnames          = local.workspace["hostnames"]
  hosted_zone        = local.workspace["hosted_zone"]
  certificate_arn    = data.aws_acm_certificate.domain_host.arn
  custom_efs_dir     = local.workspace["custom_efs_dir"]
  userdata           = <<EOT
INSTANCE_ID=`curl -w '\n' -s http://169.254.169.254/latest/meta-data/instance-id`

ALLOCATION_ID=`aws --region ${data.aws_region.current.name} ec2 describe-addresses --allocation-ids ${aws_eip.stateful.id} --query 'Addresses[0].AssociationId' --output text`
aws --region ${data.aws_region.current.name} ec2 disassociate-address --allocation-id $${ALLOCATION_ID} || true
sleep 5
aws --region ${data.aws_region.current.name} ec2 associate-address --allocation-id ${aws_eip.stateful.id} --instance-id $${INSTANCE_ID}
EOT

}

resource "aws_iam_policy" "stateful" {
  name        = "stateful-${local.workspace["account_name"]}"
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

resource "aws_iam_role_policy_attachment" "stateful_extra" {
  role       = module.eip_stateful.stateful_iam_role_name
  policy_arn = aws_iam_policy.stateful.arn
}

resource "aws_security_group" "stateful" {
  name   = "stateful-${local.workspace["account_name"]}"
  vpc_id = data.aws_vpc.selected.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}