locals {
  module_name = "public_ip"

  module_tags = {
    module-name = local.module_name
  }
}

# Create a public IP
resource "azurerm_public_ip" "public_ip" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  domain_name_label   = var.domain_name_label
  ip_version          = var.ip_version
  sku                 = var.sku

  tags = merge(var.tags, local.module_tags)
}
