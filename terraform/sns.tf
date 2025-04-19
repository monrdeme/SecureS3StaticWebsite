# Configures an SNS topic and subscription for notifications

# Create SNS topic for notifications
resource "aws_sns_topic" "security_alerts" {
  name = "${var.project_name}-security-alerts"
}

# Create email subscription for the SNS topic
resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.security_alerts.arn
  protocol  = "email"
  endpoint  = var.sns_email
}
