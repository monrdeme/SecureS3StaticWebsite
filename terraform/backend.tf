#Tells terraform where and how to store its state file but doesn't actually create any resources (s3 bucket, DynamoDb table)

terraform {
  backend "s3" {
    bucket         = "your-tf-state-bucket-name"
    key            = "secure-static-site/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
