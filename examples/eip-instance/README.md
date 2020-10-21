# Example - EIP Single Instance

In this scenario there is only one EC2 instance running with an Elastic IP attached.

This examples shows:

  - Usages of private VPC
  - Provision an Elastic IP and via an extra user data attach it to the EC2 instance.
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|


## Outputs

No output.
