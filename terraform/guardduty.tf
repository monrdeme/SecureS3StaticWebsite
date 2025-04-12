#Enables guardduty and attaches aws account to it

resource "aws_guardduty_detector" "main" {
  enable = true
}

resource "aws_guardduty_member" "self" {
  detector_id = aws_guardduty_detector.main.id
  account_id  = data.aws_caller_identity.current.account_id
  email       = var.sns_email
  disable_email_notification = false
  invite      = true
}
