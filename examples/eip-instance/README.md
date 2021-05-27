# Example - EIP Single Instance

In this scenario there is only one EC2 instance running with an Elastic IP attached.

Resources to be created via this stack:

  - Usages of private VPC
  - Provision an Elastic IP and attach it to the EC2 instance
  - You can log into the instance via SSM (Session Manager)
  - You can also get the SSM key from a SSM parameter and connect via OpenVPN