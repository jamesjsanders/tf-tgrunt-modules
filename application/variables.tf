variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
  type        = string
}

variable "aws_profile" {
  description = "The AWS profile to use for deploy"
  type        = string
}

variable "vpc_main_name" {
  type        = string
  description = "VPC Main Name"
}

variable "vpc_main_id" {
  type        = string
  description = "VPC Main ID"
}

variable "environment" {
  type        = string
  description = "Environment for vpc (production, staging, etc)"
}

variable "availability_zone_b" {
  type        = string
  description = "Availability Zone B"
}

variable "availability_zone_d" {
  type        = string
  description = "Availability Zone D"
}

variable "aws_subnet_public1_id" {
  type        = string
  description = "Subnet Public 1 ID"
}

variable "aws_subnet_public2_id" {
  type        = string
  description = "Subnet Public 2 ID"
}

variable "aws_subnet_private1_id" {
  type        = string
  description = "Subnet Private 1 ID"
}

variable "aws_subnet_private2_id" {
  type        = string
  description = "Subnet Private 2 ID"
}

variable "aws_security_group_private_id" {
  type        = string
  description = "Security Group Private ID"
}

variable "aws_security_group_bastion_id" {
  type        = string
  description = "Security Group Bastion ID"
}

variable "aws_security_group_elb_id" {
  type        = string
  description = "Security Group ELB ID"
}

variable "maintenance_window" {
  type        = string
  description = "Maintenance Window"
}

variable "rds_db_root_password" {
  type        = string
  description = "RDS Root Password"
}

variable "elasticache_group_node_size" {
  type        = string
  description = "Elasticache Group Node Size"
  default     = "cache.t2.micro"
}

variable "elasticache_number_cache_clusters" {
  type        = number
  description = "Elasticache Cache Cluster Count"
  default     = 2
}

variable "web_instance_count" {
  description = "Number of Web instances to launch"
  type        = number
  default     = 1
}

variable "ec2_web_ami" {
  type        = string
  description = "EC2 AMI"
}

variable "ec2_web_instance_type" {
  type        = string
  description = "EC2 AMI"
  default     = "t3a.medium"
}
