# Enables GuardDuty for monitoring and alerts

# Enable GuardDuty for the account
resource "aws_guardduty_detector" "main" {
  enable = true
}

