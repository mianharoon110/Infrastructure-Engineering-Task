# AWS public subnet resource definition
resource "aws_subnet" "public_subnet" {
  count                   = 2                                  # Create 2 public subnets
  cidr_block              = var.public_cidrs[count.index]      # CIDR block defined in variables
  vpc_id                  = aws_vpc.altercloud_vpc.id          # Reference to the VPC resource
  availability_zone       = var.availability_zone[count.index] # Availability zone defined in variables
  map_public_ip_on_launch = true                               # Assign public IP to instances in this subnet

  tags = {
    Name = "public-subnet" # Tag to identify the subnet
  }
}

# AWS private subnet resource definition
resource "aws_subnet" "private_subnet" {
  count             = 2                                    # Create 2 private subnets
  vpc_id            = aws_vpc.altercloud_vpc.id            # Reference to the VPC resource
  cidr_block        = var.private_subnet_cidr[count.index] # CIDR block defined in variables
  availability_zone = var.availability_zone[count.index]   # Availability zone defined in variables

  tags = {
    Name = "private-subnet" # Tag to identify the subnet
  }
}