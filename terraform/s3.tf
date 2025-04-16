# Creates the S3 bucket for hosting the website and the logging bucket. Includes bucket policies, encryption, and tagging

# Creates the S3 bucket for the website
resource "aws_s3_bucket" "website" {
  bucket = "${var.project_name}-website"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = var.project_name
    Environment = "Production"
  }
}

# Restrict public access to the website bucket
resource "aws_s3_bucket_public_access_block" "website_block" {
  bucket = aws_s3_bucket.website.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Create S3 bucket for access logs
resource "aws_s3_bucket" "logs" {
  bucket = "${var.project_name}-logs"

  tags = {
    Name        = "${var.project_name}-logs"
    Environment = "Production"
  }
}
