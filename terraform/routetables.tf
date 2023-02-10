# Define a public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.altercloud_vpc.id

  # Route for Internet traffic
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  # Ensure that the internet gateway is created before creating the route table
  depends_on = [
    aws_internet_gateway.internet_gateway
  ]

  tags = {
    Name = "igw-rtb"
  }
}

# Associate the public subnets with the public route table
resource "aws_route_table_association" "public_subnet_assoc" {
  count          = 2
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

# Define a private route table for the NAT gateway
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.altercloud_vpc.id

  # Route for NAT traffic
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
  # Ensure that the NAT gateway is created before creating the route table
  depends_on = [
    aws_nat_gateway.nat_gateway
  ]

  tags = {
    Name = "ngw-rtb"
  }
}

# Associate the private subnets with the private route table
resource "aws_route_table_association" "private_subnet_assoc" {
  count          = 2
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet[count.index].id
  depends_on = [
    aws_route_table.private_route_table
  ]
}