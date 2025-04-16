# This defines reusable variables for the project

# Project name variable used for resource naming
variable "project_name" {
  default = "secure-static-site"
}

# AWS region variable to set the deployment region
variable "region" {
  default = "us-east-1"
}

# Email variable for SNS notifications
variable "sns_email" {
  default = "dmonroe1026@gmail.com"
}
