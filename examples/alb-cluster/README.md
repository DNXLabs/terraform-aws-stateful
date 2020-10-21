# Example - ALB Cluster

In this scenario there multiple instances can be created.

This examples shows:

  - Creates an auto scaling group per instance
  - Usages of private VPC
  - Provision an AL
  - Creates the DNS record
  - You can log into the instance via SSM (Session Manager).
  - You can also get the SSM key from a SSM parameter and connect via OpenVPN.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_account\_id | n/a | `any` | n/a | yes |
| aws\_role | n/a | `any` | n/a | yes |
| account\_name | `any` | `string` | `"eu-west-1"` | no |
| region | AWS Region | `string` | `"runners-default"` | no |
| instance_type | Default: t2.micro | `string` | `"https://gitlab.com"` | no |
| hosted_zone | Root hosted zone | `string` | `"https://gitlab.com"` | no |
| hostnames | n/a | DNS to be created on Route 53 | `"generated/id_rsa"` | no |
| custom_efs_dir | Which folder EFS will be mounted | `string` | `"generated/id_rsa.pub"` | no |
| instance_count | number of EC2 instances running - must be 1 to use an Elastic IP | `any` | n/a | yes |
| enable_alb | Enables ALB | `any` | n/a | yes |
| hostname_create | Creates a DNS record poiting to the ALB URL | `any` | n/a | yes |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_account\_id | n/a | `any` | n/a | yes |
| aws\_role | n/a | `any` | n/a | yes |

## Outputs

No output.
