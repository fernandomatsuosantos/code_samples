# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

locals {
  # Local variables for resource tags
  tag_creator    = "terraform"
  tag_tf_version = "0.15.5"
}

# Create a resource group for the platform runtime
module "resource_group_01" {
  source   = "../../modules/resource_group/"
  name     = "${var.project_name}-rg-${var.region}-${var.stage}"
  location = var.location

  tags = {
    creator    = local.tag_creator
    tf-version = local.tag_tf_version
    env        = var.stage
  }
}

# Create a Virtual Network
module "virtual_network" {
  source              = "../../modules/virtual_network/"
  name                = "${var.project_name}-vnet-01-${var.region}-${var.stage}"
  resource_group_name = module.resource_group_01.name
  location            = module.resource_group_01.location
  address_space       = [var.vnet_01_address_space]

  tags = {
    creator    = local.tag_creator
    tf-version = local.tag_tf_version
    env        = var.stage
  }
}

# Create an AKS Cluster for the runtime
module "kubernetes_cluster" {
  source               = "../../modules/kubernetes_cluster"
  name                 = "${var.project_name}-aks-01-${var.region}-${var.stage}"
  subnet_name          = "${var.project_name}-snet-aks-01-${var.region}-${var.stage}"
  availability_zones   = var.aks_01_availability_zones
  resource_group_name  = module.resource_group_01.name
  location             = module.resource_group_01.location
  kubernetes_version   = var.aks_01_kubernetes_version
  orchestrator_version = var.aks_01_orchestrator_version
  vm_size              = var.aks_01_vm_size
  max_pods             = var.aks_01_max_pods
  vnet_name            = module.virtual_network.name
  vnet_address_space   = [var.aks_01_subnet_address_prefix]
  load_balancer_sku    = var.aks_01_load_balancer_sku
  min_count            = var.aks_01_auto_scaling_min_count
  max_count            = var.aks_01_auto_scaling_max_count
  os_disk_size_gb      = var.aks_01_os_disk_size_gb
  service_endpoints    = ["Microsoft.Storage"]
  aks_name             = module.kubernetes_cluster.name

  tags = {
    creator    = local.tag_creator
    tf-version = local.tag_tf_version
    env        = var.stage
  }
}

# Create an Application Gateway / WAF
module "application_gateway" {
  source = "../../modules/application_gateway_waf_v2/"

  # Public IP
  pip_name              = "${var.project_name}-appgw-pip-01-${var.region}-${var.stage}"
  pip_domain_name_label = "${var.stage}-${var.project_name}"
  pip_ip_version        = "IPv4"
  pip_sku               = "Standard"

  # Application Gateway (aka Web Application Firewall)
  name                    = "${var.project_name}-appgw-01-${var.region}-${var.stage}"
  subnet_name             = "${var.project_name}-snet-appgw-01-${var.region}-${var.stage}"
  resource_group_name     = module.resource_group_01.name
  location                = module.resource_group_01.location
  vnet_id                 = module.virtual_network.id
  vnet_name               = module.virtual_network.name
  vnet_address_space      = [var.waf_01_subnet_address_prefix]
  backend_port            = 80
  backend_request_timeout = 5
  backend_address_pool    = [var.waf_01_backend_address]

  tags = {
    creator    = local.tag_creator
    tf-version = local.tag_tf_version
    env        = var.stage
  }
}

# Create a WAF policy
module "web_application_firewall_policy" {
  source              = "../../modules/web_application_firewall_policy/"
  name                = "${var.project_name}-waf-policy-01-${var.region}-${var.stage}"
  resource_group_name = module.resource_group_01.name
  location            = module.resource_group_01.location

  tags = {
    creator    = local.tag_creator
    tf-version = local.tag_tf_version
    env        = var.stage
  }
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

  tags = {
    creator    = local.tag_creator
    tf-version = local.tag_tf_version
    env        = var.stage
  }
}
