variable "name" {
  description = "Name of this EC2 Instance"
  type        = string
}

variable "instance_type" {
  default     = "t2.micro"
  description = "EC2 instance type"
  type        = string
}

variable "on_demand_base_capacity" {
  description = "on_demand_base_capacity"
  default     = 0
  type        = number
}

variable "on_demand_percentage" {
  description = "on_demand_percentage"
  default     = 0
  type        = number
}

variable "instance_count" {
  default     = 1
  description = "Number of EC2 intances"
  type        = number
}

variable "lb_type" {
  default     = ""
  description = "Either ALB, NLB or EIP to enable"
  type        = string
}

variable "lb_scheme" {
  default     = "external"
  description = "Wheter to use an external ALB/NLB or internal (not applicable for EIP)"
  type        = string
}

variable "tcp_ports" {
  type        = list(any)
  default     = []
  description = "List TCP ports to listen (only when lb_type is NLB or EIP)"
}

variable "udp_ports" {
  type        = list(any)
  default     = []
  description = "List of UDP ports to listen (only when lb_type is NLB or EIP)"
}

variable "sg_cidr_blocks" {
  type        = list(any)
  default     = []
  description = "Which cidr blocks allowed to connect to the service"
}

variable "certificate_arn" {
  default     = ""
  description = "Certificate ARN to be used on the ALB"
  type        = string
}

variable "userdata" {
  default     = ""
  description = "Extra commands to pass to userdata"
}

variable "fs_type" {
  default     = "EFS"
  description = "Filesystem persistency to use: EFS or EBS"
  type        = string
}

variable "efs_mount_dir" {
  default     = "/mnt/efs"
  description = "Custom EFS mount point - e.g /home"
  type        = string
}

variable "ebs_root_size" {
  default     = 40
  description = "Size of EBS root volume in GB"
}

variable "ebs_size" {
  default     = 40
  description = "Size of EBS volumes in GB"
  type        = number
}

variable "ebs_encrypted" {
  default     = true
  description = "Encrypts EBS volume"
  type        = bool
}

variable "ebs_kms_key_id" {
  default     = ""
  description = "Encrypts EBS volume with custom KMS key (requires ebs_encrypted=true)"
  type        = string
}

variable "ebs_type" {
  default     = "gp2"
  description = "EBS volume type"
  type        = string
}

variable "ebs_mount_dir" {
  default     = "/mnt/ebs"
  description = "Custom EBS mount point - e.g /home"
  type        = string
}

variable "instances_subnet_ids" {
  type        = list(any)
  description = "List of private subnet IDs for EC2 instances (same number as instance_count)"
}

variable "lb_subnet_ids" {
  type        = list(any)
  default     = []
  description = "List of subnet IDs for the ALB/NLB"
}

variable "efs_subnet_ids" {
  type        = list(any)
  default     = []
  description = "List of secure subnet IDs for EFS"
}

variable "vpc_id" {
  description = "VPC ID to deploy the EC2/default cluster"
  type        = string
}

variable "security_group_ids" {
  type        = list(any)
  default     = []
  description = "Extra security groups for instances"
}

variable "sg_custom_ingress_rules" {
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))
  default     = []
  description = "Which cidr blocks allowed to connect to the service"
}

variable "sg_custom_egress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default     = []
  description = "Which cidr blocks allowed to connect to the service"
}

variable "hostname_create" {
  default     = false
  description = "Wheter to create the hostnames on Route 53"
}

variable "hosted_zone" {
  default     = ""
  description = "Route 53 hosted zone"
  type        = string
}

variable "hostnames" {
  default     = []
  description = "Hostnames to be created on Route 53"
  type        = list(string)
}

variable "launch_template_id" {
  default     = ""
  description = "Uses an existing launch template"
  type        = string
}

variable "ami_id" {
  default     = ""
  description = "AMI to use (leave blank to use latest Amazon Linux 2)"
  type        = string
}

variable "cwlog_files" {
  default     = []
  description = "List of log files to stream to cloudwatch logs (leave empty to disable the agent) - only for Amazon Linux 2 AMIs"
}

variable "tags" {
  default     = {}
  description = "Additional resource tags"
  type        = map(string)
}

variable "http_port" {
  default     = 80
  description = "HTTP port to listen (only when lb_type is ALB"
  type        = number
}