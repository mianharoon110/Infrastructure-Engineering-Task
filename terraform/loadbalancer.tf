# Define an AWS Application Load Balancer
resource "aws_lb" "alb" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_subnet.*.id
  tags = {
    Name = "altercloud-alb"
  }
}

# Define an AWS Target Group for the ALB
resource "aws_lb_target_group" "alb_tg" {
  name        = "app-tg"
  target_type = "instance"
  vpc_id      = aws_vpc.altercloud_vpc.id
  port        = 80
  protocol    = "HTTP"

  # Define the health check for the target group
  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# Define an AWS Load Balancer Listener for the ALB
resource "aws_lb_listener" "http_listener" {
  # Associate the listener with the specified ALB
  load_balancer_arn = aws_lb.alb.arn
  # Define the default action for the listener
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }

  port     = 80
  protocol = "HTTP"
}