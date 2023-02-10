# Define a resource for the Bastion Host EC2 instance
resource "aws_instance" "bastion_host" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true

  # Use the specified SSH key pair for accessing the instance
  key_name = aws_key_pair.servers_ssh_key.key_name
  # Launch the instance in the specified public subnet
  subnet_id = aws_subnet.public_subnet[0].id

  vpc_security_group_ids = [aws_security_group.bastion_host_sg.id]

  # Add a tag to the instance for easier identification
  tags = {
    Name = "bastion-host"
  }
}