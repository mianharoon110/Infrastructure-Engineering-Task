# This block creates a security group for the Application Load Balancer (ALB)
resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.altercloud_vpc.id
  name   = "allow-alb"

  dynamic "ingress" {
    # Iterate over the `local.alb_ports_in` set to create rules for each port
    for_each = toset(local.alb_ports_in)
    content {
      description = "Web Traffic from internet"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    # Iterate over the `local.outbound_access` set to create rules for each port
    for_each = toset(local.outbound_access)
    content {
      description = "Outbound traffic"
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "alb-sg"
  }
}

# This block creates a security group for the application servers
resource "aws_security_group" "app_sg" {
  name   = "allow-app"
  vpc_id = aws_vpc.altercloud_vpc.id

  dynamic "ingress" {
    for_each = toset(local.app_ports_in)
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.alb_sg.id, aws_security_group.bastion_host_sg.id]
    }
  }

  dynamic "egress" {
    for_each = toset(local.app_ports_out)
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "app-sg"
  }
}

# Bastion Host Security Group
resource "aws_security_group" "bastion_host_sg" {
  name   = "allow-ssh" # Give a descriptive name to the security group
  vpc_id = aws_vpc.altercloud_vpc.id

  dynamic "ingress" {
    for_each = toset(local.bastion_ports) # Loop through the list of ports to be opened
    content {
      description = "Allow SSH from VPN"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.whitelist_ips
    }
  }

  dynamic "egress" {
    for_each = toset(local.bastion_ports)
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "bastion-host-sg"
  }
}