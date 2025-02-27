variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
  sensitive   = true
}

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

variable "vpc_public_subnets_cidr_block" {
  type        = list(string)
  description = "CIDR Block for Public Subnets in VPC"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}
variable "vpc_private_subnets_cidr_block" {
  type        = list(string)
  description = "CIDR Block for Private Subnets in VPC"
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
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
