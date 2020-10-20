# terraform-aws-stateful

This terraform module creates an EC2 Cluster on AWS.

The following resources will be created:

- Elastic File System (EFS)
- Auto Scaling
- Security groups for (ALB,EC2,EFS)
- Web Application Firewall (WAF)
- IAM roles and policies for the EC2 instances

In addition you have the option to create or not :
 - Application Load Balancer (ALB)
     - alb - An external ALB

 - Route 53 (requires ALB)
     - ALB URL poiting to a hostname

## Usage

For deployment usage please see the `examples` folder.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| certificate\_arn | Certificate ARN to be used on the ALB | `any` | n/a | yes |
| custom\_efs\_dir | Custom EFS mount point - e.g /home | `string` | `""` | no |
| enable\_alb | Wheter to enable application load balancer | `bool` | `false` | no |
| hosted\_zone | Route 53 hosted zone | `string` | `""` | no |
| hostname\_create | Wheter to create the hostnames on Route 53 | `bool` | `false` | no |
| hostnames | Hostnames to be created on Route 53 | `any` | n/a | yes |
| instance\_count | Number of EC2 intances | `number` | `1` | no |
| instance\_type | EC2 instance type | `string` | `"t2.micro"` | no |
| instance\_volume\_size\_root | Volume root size | `number` | `16` | no |
| instances\_subnet | List of private subnet IDs for EC2 instances | `list` | n/a | yes |
| name | Name of this EC2/stateful cluster | `any` | n/a | yes |
| public\_subnet\_ids | List of public subnet IDs for the ALB | `list` | `[]` | no |
| secure\_subnet\_ids | List of secure subnet IDs for EFS | `list` | n/a | yes |
| security\_group\_ids | Extra security groups for instances | `list` | `[]` | no |
| userdata | Extra commands to pass to userdata | `string` | `""` | no |
| vpc\_id | VPC ID to deploy the EC2/stateful cluster | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| stateful\_iam\_role\_name | n/a |

