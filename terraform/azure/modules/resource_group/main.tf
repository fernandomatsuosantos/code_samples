locals {
  module_name = "resource_group"

  module_tags = {
    module-name = local.module_name
  }
}

# Create a resource group
resource "azurerm_resource_group" "resource_group" {
  name     = var.name
  location = var.location

  tags = merge(var.tags, local.module_tags)
}

