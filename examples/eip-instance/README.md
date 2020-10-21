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
| account\_name | `any` | `string` | n/a | no |
| region | AWS Region | `string` | n/a | no |
| instance_type | EC2 instance type | `string` | t2.micro | no |
| hosted_zone | Root hosted zone | `string` | n/a | no |
| hostnames | n/a | DNS to be created on Route 53 | n/a | no |
| custom_efs_dir | Which folder EFS will be mounted | `string` | `/mnt/efs` | no |
| instance_count | number of EC2 instances running - must be 1 to use an Elastic IP | `any` | n/a | yes |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|


## Outputs

No output.
