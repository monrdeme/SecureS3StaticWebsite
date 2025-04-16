terraform {
  backend "s3" {
    bucket         = "secure-static-site-tf-state"      # <-- hardcoded
    key            = "secure-static-site/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "secure-static-site-tf-locks"      # <-- hardcoded
  }
}
