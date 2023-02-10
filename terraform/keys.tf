# Define an AWS Key Pair resource
resource "aws_key_pair" "servers_ssh_key" {
  key_name   = "altercloud-key"
  public_key = var.public_key
}