variable "name" {
  description = "Name of this EC2 Instance"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "instance_count" {
  default     = 1
  description = "Number of EC2 intances"
}

variable "lb_type" {
  default     = ""
  description = "Either ALB, NLB or EIP to enable"
}

variable "lb_scheme" {
  default     = "external"
  description = "Wheter to use an external ALB/NLB or internal (not applicable for EIP)"
}

variable "tcp_ports" {
  type        = list
  default     = []
  description = "List TCP ports to listen (only when lb_type is NLB or EIP)"
}

variable "udp_ports" {
  type        = list
  default     = []
  description = "List of UDP ports to listen (only when lb_type is NLB or EIP)"
}

variable "sg_cidr_blocks" {
  type        = list
  default     = []
  description = "Which cidr blocks allowed to connect to the service"
}

variable "certificate_arn" {
  default     = ""
  description = "Certificate ARN to be used on the ALB"
}

variable "userdata" {
  default     = ""
  description = "Extra commands to pass to userdata"
}

variable "fs_type" {
  default     = "EFS"
  description = "Filesystem persistency to use: EFS or EBS"
}

variable "efs_mount_dir" {
  default     = "/mnt/efs"
  description = "Custom EFS mount point - e.g /home"
}

variable "ebs_size" {
  default     = 40
  description = "Size of EBS volumes in GB"
}

variable "ebs_encrypted" {
  default     = true
  description = "Encrypts EBS volume"
}

variable "ebs_kms_key_id" {
  default     = ""
  description = "Encrypts EBS volume with custom KMS key (requires ebs_encrypted=true)"
}

variable "ebs_type" {
  default     = "gp2"
  description = "EBS volume type"
}

variable "ebs_mount_dir" {
  default = "/mnt/ebs"
  description = "Custom EBS mount point - e.g /home"
}

variable "instances_subnet_ids" {
  type        = list
  description = "List of private subnet IDs for EC2 instances (same number as instance_count)"
}

variable "lb_subnet_ids" {
  type        = list
  default     = []
  description = "List of subnet IDs for the ALB/NLB"
}

variable "efs_subnet_ids" {
  type        = list
  default     = []
  description = "List of secure subnet IDs for EFS"
}

variable "vpc_id" {
  description = "VPC ID to deploy the EC2/default cluster"
}

variable "security_group_ids" {
  type        = list
  default     = []
  description = "Extra security groups for instances"
}

variable "hostname_create" {
  default     = false
  description = "Wheter to create the hostnames on Route 53"
}

variable "hosted_zone" {
  default     = ""
  description = "Route 53 hosted zone"
}

variable "hostnames" {
  default     = []
  description = "Hostnames to be created on Route 53"
}

variable "ami_id" {
  default     = ""
  description = "AMI to use (leave blank to use latest Amazon Linux 2)"
}