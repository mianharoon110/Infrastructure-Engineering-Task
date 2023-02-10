#!/bin/bash

# exits script in case of an error
set -e

cd terraform

# Initialize Terraform
terraform init

# Check the Terraform plan
terraform plan

# Apply the Terraform code
terraform apply