variable "name" {
  description = "Name of this EC2 cluster"
}

variable "cluster_name" {
  description = "Environment name"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "on_demand_base_capacity" {
  description = "on_demand_base_capacity"
}

variable "on_demand_percentage" {
  description = "on_demand_percentage"
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
  description = "Either alb nlb or EIP to enable"
}

variable "lb_port" {
  type        = number
  default     = 0
  description = "LB port"
}

variable "lb_protocol" {
  default     = ""
  description = "LB protocol"
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

variable "instance_volume_size_root" {
  default     = 16
  description = "Volume root size"
}

variable "custom_efs_dir" {
  default     = ""
  description = "Custom EFS mount point - e.g /home"
}

variable "instances_subnet" {
  type        = list
  description = "List of private subnet IDs for EC2 instances"
}

variable "public_subnet_ids" {
  type        = list
  default     = []
  description = "List of public subnet IDs for the ALB"
}

variable "secure_subnet_ids" {
  type        = list
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