# Configure the Terraform version and required providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.27"
    }
  }

  required_version = ">= 0.13"
}

# Configure the AWS provider with the specified access and secret keys
provider "aws" {
  region = var.region
}