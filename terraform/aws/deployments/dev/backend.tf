#https://github.com/hashicorp/terraform/releases
terraform {
  required_version = "~> 0.15.0"
  backend "s3" {
    bucket         = "fms-modus-terraform-tfstate"
    key            = "terraform-prod.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform"
  }
}