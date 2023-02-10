# Create a VPC with a specified CIDR block
resource "aws_vpc" "altercloud_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "altercloud-vpc"
  }
}