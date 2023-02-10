resource "aws_eip" "nat_gw_eip" {
  vpc = true
  # Declare a dependency
  depends_on = [
    aws_route_table_association.public_subnet_assoc
  ]
  # Define tags to identify and categorize the Elastic IP
  tags = {
    Name = "nat-gw-eip"
  }
}