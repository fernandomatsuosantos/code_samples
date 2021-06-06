locals {
  module_name = "postgresql_server"

  module_tags = {
    module-name = local.module_name
  }
}

resource "azurerm_postgresql_server" "postgresql_server" {
  # checkov:skip=CKV_AZURE_68: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AZURE_102: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AZURE_128: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AZURE_130: "Since this is just a demo this check will be ignored"

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  sku_name   = var.sku_name
  version    = var.postgresql_server_version
  storage_mb = var.storage_mb

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  auto_grow_enabled            = var.auto_grow_enabled

  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  ssl_enforcement_enabled           = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced  = var.ssl_minimal_tls_version_enforced

  dynamic "threat_detection_policy" {
    for_each = substr(var.sku_name, 0, 2) != "B_" ? ["true"] : []

    content {
      enabled = var.threat_detection_policy_enabled
    }
  }
}

# Configure PostgreSQL Server firewall to allow connections from any clients
resource "azurerm_postgresql_firewall_rule" "postgresql_server_firewall_rule" {
  # checkov:skip=CKV_AZURE_11: "Since this is just a demo this check will be ignored"

  name                = "allow_all"
  resource_group_name = azurerm_postgresql_server.postgresql_server.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql_server.name
  start_ip_address    = var.postgresql_firewall_start_ip_address
  end_ip_address      = var.postgresql_firewall_end_ip_address
}

# Enable log_connections configuration on PostgreSQL Server
resource "azurerm_postgresql_configuration" "log_connections" {
  name                = "log_connections"
  resource_group_name = azurerm_postgresql_server.postgresql_server.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql_server.name
  value               = "on"
}

# Enable log_checkpoints configuration on PostgreSQL Server
resource "azurerm_postgresql_configuration" "log_checkpoints" {
  name                = "log_checkpoints"
  resource_group_name = azurerm_postgresql_server.postgresql_server.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql_server.name
  value               = "on"
}
