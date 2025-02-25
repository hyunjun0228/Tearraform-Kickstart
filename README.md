# Terraform Lessons

This repository contains notes, examples, and best practices I’ve learned while studying **Terraform**, an Infrastructure as Code (IaC) tool.

## Overview

- **Infrastructure as Code (IaC)**: Manage and provision cloud resources using declarative configuration files instead of manual processes.
- **Terraform**: An open-source tool by HashiCorp that lets you define, preview, and deploy infrastructure resources across multiple cloud providers.

## Topics Covered

1. **Basic Terraform Concepts**
   - **Providers**: The plugins that interact with various cloud platforms (e.g., AWS, Azure, GCP).
   - **Resources**: The actual cloud components (e.g., EC2 instances, S3 buckets).
   - **Data Sources**: Used to retrieve information or configurations from providers or other sources.
   - **Variables and Outputs**: Handling dynamic values and exposing useful information.
   - **State Management**: Terraform’s state file tracks the current state of deployed infrastructure.

2. **AWS-Specific Resources**
   - **VPC, Subnets, Internet Gateway**: Setting up a network environment.
   - **EC2 Instances**: Launching and configuring virtual machines.
   - **Security Groups**: Controlling inbound and outbound traffic.
   - **Load Balancers & Target Groups**: Distributing traffic to multiple backend instances.
   - **RDS**: Working with managed databases.

3. **Terraform Configuration Examples**
   - **Organizing Code**: Using multiple `.tf` files (e.g., `main.tf`, `variables.tf`, `outputs.tf`) for clarity.
   - **Modules**: Reusing configuration blocks to avoid duplication.
   - **Remote State**: Storing and locking state in a shared backend like S3.

4. **Best Practices**
   - **Version Control**: Storing Terraform code in Git for collaboration and history tracking.
   - **Consistent Naming**: Ensuring resources follow a clear naming convention.
   - **terraform fmt & terraform validate**: Auto-formatting and validating code to avoid errors.
   - **Plan Before Apply**: Always run `terraform plan` to see potential changes before executing `terraform apply`.

## Repository Structure

```shell
.
├── main.tf             # Core Terraform configuration
├── variables.tf        # Input variables definitions
├── outputs.tf          # Output values
├── modules/            # Custom modules (if any)
├── examples/           # Sample configurations for reference
└── README.md           # This file
```

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/terraform-lessons.git
   ```
2. **Initialize Terraform**:
   ```bash
   cd terraform-lessons
   terraform init
   ```
3. **Review Plan & Apply**:
   ```bash
   terraform plan
   terraform apply
   ```

## Future Updates

- More advanced **Terraform modules**.
- Integrating **CI/CD** for automated Terraform deployments.
- Using **Terraform Cloud** or other remote backends for state management.
- Examples with **Azure** or **GCP** for multi-cloud coverage.

## Contributing

Feel free to open issues or pull requests if you find any errors or if you’d like to contribute additional examples or best practices.

## License

This project is licensed under the [MIT License](LICENSE). 

---

Feel free to customize this **README.md** to reflect your specific lessons, any code examples you wish to highlight, and the structure of your own repository.
