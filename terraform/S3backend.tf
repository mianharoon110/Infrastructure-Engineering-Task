# Configure Terraform backend to store state files in an S3 bucket
terraform {
  backend "s3" {
    bucket = "terraform-state-files-110"
    # Key (filename) for the Terraform state file in the S3 bucket
    key    = "terraform.tfstate"
    region = "eu-central-1"
    # Name of the DynamoDB table to lock the Terraform state file
    dynamodb_table = "terraform-state-lock"
  }
}