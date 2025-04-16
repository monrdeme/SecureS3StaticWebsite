# Output the IAM user's access key
output "access_key_id" {
  value       = aws_iam_access_key.user_access_key.id
  description = "The access key ID for the IAM user"
  sensitive   = true
}

# Output the IAM user's secret access key
output "secret_access_key" {
  value       = aws_iam_access_key.user_access_key.secret
  description = "The secret access key for the IAM user"
  sensitive   = true
}
