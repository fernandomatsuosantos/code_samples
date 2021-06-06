locals {
  module_name = "virtual_network"

  module_tags = {
    module-name = local.module_name
  }
}

# Create a Virtual Network
resource "azurerm_virtual_network" "virtual_network" {
  name                = var.name
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  location            = var.location

  tags = merge(var.tags, local.module_tags)
}
