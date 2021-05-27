# Example - NLB Cluster

In this scenario, multiple instances can be created.

Resources to be created via this stack:

  - An auto scaling group per instance
  - Usages of private VPC
  - Provision an NLB
  - Creates the DNS record pointing to the NLB hostname
  - You can log into the instance via SSM (Session Manager)
  - You can also get the SSH key from a SSM parameter and connect via OpenVPN
