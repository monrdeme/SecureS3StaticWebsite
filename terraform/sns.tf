#Creates an SNS topic and creates a subscription to that topic, sending email notifications defined by a variable

resource "aws_sns_topic" "gd_alerts" {
  name = "${var.project_name}-alerts"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.gd_alerts.arn
  protocol  = "email"
  endpoint  = var.sns_email
}
