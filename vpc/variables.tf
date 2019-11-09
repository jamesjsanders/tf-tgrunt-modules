### Variables
variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
  type        = string
}

variable "environment" {
  type        = string
  description = "Environment for vpc (production, staging, etc)"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "vpc desired CIDR block"
  default     = "10.0.0.0/16"
}

variable "availability_zone_b" {
  type        = string
  description = "vpc desired CIDR block"
}

variable "availability_zone_d" {
  type        = string
  description = "vpc desired CIDR block"
}

variable "public1_subnet" {
  type        = string
  description = "Public 1 Subnet"
}

variable "public2_subnet" {
  type        = string
  description = "Public 2 Subnet"
}

variable "private1_subnet" {
  type        = string
  description = "Private 1 Subnet"
}

variable "private2_subnet" {
  type        = string
  description = "Private 2 Subnet"
}
