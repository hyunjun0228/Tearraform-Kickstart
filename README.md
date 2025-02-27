# Terraform AWS Deployment: Load Balancer with EC2 Instances

This repository contains Terraform scripts to deploy **two EC2 instances** behind an **Application Load Balancer (ALB)** on AWS. The setup includes networking, security groups, and required configurations to automate infrastructure deployment.

## 📌 Overview

This Terraform configuration provisions:

- **Two EC2 instances** behind an **Application Load Balancer (ALB)**
- A **VPC** with public and private subnets
- Security groups to control access
- An **Auto Scaling Group (ASG)** (if configured)
- **Target Groups & Listener Rules** for the ALB
- Output values such as ALB DNS and EC2 instance details

## 🛠 Prerequisites

Ensure you have the following:

- **AWS Account** with appropriate IAM permissions
- **Terraform installed** (`terraform >= 1.0`)
- **AWS CLI configured** (`aws configure`)
- **SSH key pair** (if required to access EC2 instances)

## 📂 Repository Structure

| File                | Description                                                 |
| ------------------- | ----------------------------------------------------------- |
| `instances.tf`      | Defines the EC2 instances and their security groups         |
| `loadbalancer.tf`   | Creates the ALB, listener, and target group                 |
| `network.tf`        | Defines the VPC, subnets, and networking setup              |
| `locals.tf`         | Defines reusable local variables                            |
| `variables.tf`      | Contains input variables for the Terraform scripts          |
| `terraform.tfvars`  | Defines values for Terraform variables                      |
| `outputs.tf`        | Specifies output values such as ALB DNS                     |
| `deploy_alb_ec2.sh` | Script to initialize, format, validate, and apply Terraform |

---

## 🚀 Deployment Steps

### 1️⃣ Clone the Repository

`git clone https://github.com/yourusername/terraform-alb-ec2.git`
`cd terraform-alb-ec2`

### 2️⃣ Initialize Terraform

`terraform init`

### 3️⃣ Format & Validate Configuration

`terraform fmt`
`terraform validate`

### 4️⃣ Plan Infrastructure

`terraform plan -out deploy_alb_ec2.tfplan`

### 5️⃣ Deploy Infrastructure

`terraform apply deploy_alb_ec2.tfplan`

### 6️⃣ Get ALB DNS

Once deployed, retrieve the ALB DNS name using:

`terraform output alb_dns_name`
Use this to access the deployed application.

## 🗑 Cleanup

To destroy all resources:

`terraform destroy`

## 🔧 Customization

Modify terraform.tfvars to customize:

- AWS region
- EC2 instance type
- AMI ID
- Load balancer settings
- VPC CIDR block

## 📖 Learning Notes

This project was created as part of a Terraform learning exercise, focusing on:

- Infrastructure as Code (IaC)
- AWS resource provisioning
- Load balancing & networking
- Terraform state management
- Feel free to contribute or suggest improvements! 🚀
