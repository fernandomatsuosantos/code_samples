# https://github.com/hashicorp/terraform/releases
terraform {
  required_version = "~> 0.15.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.60"
    }
  }
}