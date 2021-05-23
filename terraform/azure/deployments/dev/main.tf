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

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group for the platform runtime
module "resource_group_01" {
  source   = "../../modules/resource_group/"
  name     = "${var.project_name}-rg-${var.region}-${var.stage}"
  location = var.location
}

# Create an AKS Cluster
module "kubernetes_cluster" {
  source              = "../../modules/kubernetes_cluster"
  name                = "${var.project_name}-aks-${var.region}-${var.stage}"
  resource_group_name = module.resource_group_01.name
  location            = var.location
  vm_size             = "Standard_B2s"
}

# Create a PostgreSQL Server
module "postgresql_server_core" {
  source              = "../../modules/postgresql_server/"
  name                = "${var.project_name}-postgresql-${var.region}-${var.stage}"
  location            = var.location
  resource_group_name = module.resource_group_01.name
  administrator_login = "poc_postgresql_server"
  # Note - password hard coded only for testing - not a good practice
  administrator_login_password = "This~is#a!P0C"
  postgresql_server_version    = "11" # only major versions are accepted https://github.com/terraform-providers/terraform-provider-azurerm/pull/3915
  sku_name                     = "B_Gen5_1"
  storage_mb                   = "5120"
  backup_retention_days        = 7
}