# Define a data source for the latest Ubuntu AMI
data "aws_ami" "ubuntu" {

  most_recent = true

  # Filter the AMIs based on their names and virtualization type
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# This resource creates an AWS Launch Configuration
resource "aws_launch_configuration" "app_conf" {

  name            = "app-config"
  image_id        = data.aws_ami.ubuntu.id                # Use the latest Ubuntu image
  instance_type   = var.instance_type                     # The instance type to use, specified as a variable
  key_name        = aws_key_pair.servers_ssh_key.key_name # Use the specified AWS Key Pair for access
  security_groups = [aws_security_group.app_sg.id]        # Use the specified security group

  # This script runs after the instance starts and clones a Git repository with a simple Python app
  # The script then runs the app using Python3
  user_data = <<EOF
#!/bin/bash
cd /home/ubuntu && git clone https://mianharoon110:${var.git_token}@github.com/mianharoon110/simple-python-app.git && python3 simple-python-app/app.py
EOF

  lifecycle {
    create_before_destroy = true # Ensure that a new instance is created before the old one is destroyed during an update
  }
}

# This resource creates an AWS Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
  name                 = "app-asg"
  launch_configuration = aws_launch_configuration.app_conf.name # Use the previously created launch configuration
  vpc_zone_identifier  = aws_subnet.private_subnet.*.id         # Use all the private subnets in the VPC
  target_group_arns    = [aws_lb_target_group.alb_tg.arn]       # Use the specified target group with the ALB
  min_size             = 2                                      # The minimum number of instances in the ASG
  max_size             = 3                                      # The maximum number of instances in the ASG

  tag {
    key                 = "Name"
    value               = "app-server" # Add a tag with the name "app-server" to the instances
    propagate_at_launch = true         # Ensure that the tag is propagated to new instances
  }

  lifecycle {
    create_before_destroy = true # Ensure that a new ASG is created before the old one is destroyed during an update
  }
}