# Configures the S3 bucket for storing Terraform state remotely

# Backend configuration using S3 for remote state storage
terraform {
  backend "s3" {
    bucket         = "${var.project_name}-tf-state"
    key            = "terraform/state.tfstate"
    region         = "var.region"
    encrypt        = true
    dynamodb_table = "${var.project_name}-tf-locks"
  }
}
