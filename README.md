# terraform-aws-template

[![Lint Status](https://github.com/DNXLabs/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-template)](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE)

This terraform module creates an EC2 Cluster on AWS.

The following resources will be created:

- Elastic File System (EFS)
- Auto Scaling
- Security groups for (ALB/NLB,EC2,EFS)
- IAM roles and policies for the EC2 instances

In addition, you have the option to create:
 - Elastic Load Balancer
     - ALB - An external Application Load Balancer
     - NLB - An external Network Load Balancer

 - Route 53 (requires ALB)
     - URL pointing to a hostname (NLB or ALB hostname)

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_id | AMI to use (leave blank to use latest Amazon Linux 2) | `string` | `""` | no |
| certificate\_arn | Certificate ARN to be used on the ALB | `string` | `""` | no |
| cwlog\_files | List of log files to stream to cloudwatch logs (leave empty to disable the agent) - only for Amazon Linux 2 AMIs | `list` | `[]` | no |
| ebs\_encrypted | Encrypts EBS volume | `bool` | `true` | no |
| ebs\_kms\_key\_id | Encrypts EBS volume with custom KMS key (requires ebs\_encrypted=true) | `string` | `""` | no |
| ebs\_mount\_dir | Custom EBS mount point - e.g /home | `string` | `"/mnt/ebs"` | no |
| ebs\_size | Size of EBS volumes in GB | `number` | `40` | no |
| ebs\_type | EBS volume type | `string` | `"gp2"` | no |
| efs\_mount\_dir | Custom EFS mount point - e.g /home | `string` | `"/mnt/efs"` | no |
| efs\_subnet\_ids | List of secure subnet IDs for EFS | `list(any)` | `[]` | no |
| fs\_type | Filesystem persistency to use: EFS or EBS | `string` | `"EFS"` | no |
| hosted\_zone | Route 53 hosted zone | `string` | `""` | no |
| hostname\_create | Wheter to create the hostnames on Route 53 | `bool` | `false` | no |
| hostnames | Hostnames to be created on Route 53 | `list` | `[]` | no |
| instance\_count | Number of EC2 intances | `number` | `1` | no |
| instance\_type | EC2 instance type | `string` | `"t2.micro"` | no |
| instances\_subnet\_ids | List of private subnet IDs for EC2 instances (same number as instance\_count) | `list(any)` | n/a | yes |
| lb\_scheme | Wheter to use an external ALB/NLB or internal (not applicable for EIP) | `string` | `"external"` | no |
| lb\_subnet\_ids | List of subnet IDs for the ALB/NLB | `list(any)` | `[]` | no |
| lb\_type | Either ALB, NLB or EIP to enable | `string` | `""` | no |
| name | Name of this EC2 Instance | `any` | n/a | yes |
| on\_demand\_base\_capacity | on\_demand\_base\_capacity | `number` | `0` | no |
| on\_demand\_percentage | on\_demand\_percentage | `number` | `0` | no |
| security\_group\_ids | Extra security groups for instances | `list(any)` | `[]` | no |
| sg\_cidr\_blocks | Which cidr blocks allowed to connect to the service | `list(any)` | `[]` | no |
| tags | Additional resource tags | `map(string)` | `{}` | no |
| tcp\_ports | List TCP ports to listen (only when lb\_type is NLB or EIP) | `list(any)` | `[]` | no |
| udp\_ports | List of UDP ports to listen (only when lb\_type is NLB or EIP) | `list(any)` | `[]` | no |
| userdata | Extra commands to pass to userdata | `string` | `""` | no |
| vpc\_id | VPC ID to deploy the EC2/default cluster | `any` | n/a | yes |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE) for full details.