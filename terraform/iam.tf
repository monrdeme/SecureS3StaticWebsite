# Defines the IAM roles and an IAM user to assume them

# Create IAM user for assuming roles
resource "aws_iam_user" "project_user" {
  name = "${var.project_name}-user"

  tags = {
    Name        = var.project_name
    Environment = "Production"
  }
}

# Attach an access key to the IAM user
resource "aws_iam_access_key" "user_access_key" {
  user = aws_iam_user.project_user.name
}

# Create admin role for full S3 access
resource "aws_iam_role" "admin_role" {
  name = "${var.project_name}-admin"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${aws_iam_user.project_user.name}" }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach policy for full S3 access to admin role
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
