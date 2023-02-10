# AWS CloudWatch Metric Alarm for monitoring the number of requests to the application
resource "aws_cloudwatch_metric_alarm" "app_request_count" {
  alarm_name          = "altercloud-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  # Metric name to use in CloudWatch alarm
  metric_name       = "RequestCount"
  namespace         = "AWS/ApplicationELB"
  period            = "60"
  statistic         = "Sum"
  threshold         = "10"
  alarm_description = "This metric checks for number of requests per minute"
  actions_enabled   = true

  # LoadBalancer dimension for CloudWatch metric
  dimensions = {
    LoadBalancer = aws_lb.alb.arn_suffix
  }
}