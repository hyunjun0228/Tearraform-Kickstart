variable "aws_region" {
  type        = string
  description = "AWS region to use for resources"
  default     = "us-east-1"
}

variable "enable_dns_hostnames_public_subnet" {
  type        = bool
  description = "Enable DNS hostnames"
  default     = "true"
}

variable "enable_dns_hostnames_private_subnet" {
  type        = bool
  description = "Enable DNS hostnames"
  default     = "false"
}

variable "vpc_cidr_block" {
  type        = string
  description = "Based CIDR Block for VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnet_counts" {
  type        = number
  description = "Number of public subnets"
  default     = 2
}

variable "vpc_public_subnets_cidr_block" {
  type        = list(string)
  description = "CIDR Block for Public Subnets in VPC"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map a public IP address for public subnet instances"
  default     = true
}

variable "instance_type" {
  type        = string
  description = "Type for EC2 instance"
  default     = "t2.micro"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances"
  default     = 2
}

variable "company" {
  type        = string
  description = "Company Tag"
  default     = "Terraform-Test"
}

variable "project" {
  type        = string
  description = "Project Name"
}

variable "billing_code" {
  type        = string
  description = "Billing Code"
}

variable "environment" {
  type        = string
  description = "Environment Name"
  default     = "development"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for project"
  default     = "max-global"
}
