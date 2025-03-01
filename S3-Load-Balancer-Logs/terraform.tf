##################################################################################
# Terraform Required Providers
##################################################################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.89.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
}
