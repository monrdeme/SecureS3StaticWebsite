# Declare the aws_caller_identity data source to get the current AWS account ID
data "aws_caller_identity" "current" {}

resource "aws_iam_user" "project_user" {
  name = "${var.project_name}-user"

  tags = {
    Name        = var.project_name
    Environment = "Production"
  }
}

resource "aws_iam_access_key" "user_access_key" {
  user = aws_iam_user.project_user.name
}

resource "aws_iam_role" "admin_role" {
  name = "${var.project_name}-admin"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${aws_iam_user.project_user.name}"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "admin_policy" {
  name = "admin-policy"
  role = aws_iam_role.admin_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "s3:*"
      Resource = "*"
    }]
  })
}
