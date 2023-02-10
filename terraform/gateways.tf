# Define an AWS Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.altercloud_vpc.id

  tags = {
    Name = "altercloud-igw"
  }
}

# Define an AWS NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {

  # Associate the NAT Gateway with the specified Elastic IP
  allocation_id = aws_eip.nat_gw_eip.id
  # Specify the subnet for the NAT Gateway
  subnet_id = aws_subnet.public_subnet[0].id

  tags = {
    Name = "altercloud-ngw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC
  depends_on = [aws_internet_gateway.internet_gateway]
}