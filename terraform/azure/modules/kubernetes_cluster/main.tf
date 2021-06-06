locals {
  module_name = "azurerm_kubernetes_cluster"

  module_tags = {
    module-name = local.module_name
  }
}

# Create a subnet for the AKS cluster
resource "azurerm_subnet" "aks_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.vnet_address_space
  service_endpoints    = var.service_endpoints
}

# Create an AKS cluster
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  # checkov:skip=CKV_AZURE_4: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AZURE_5: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AZURE_6: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AZURE_117: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AZURE_115: "Since this is just a demo this check will be ignored"

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = lower(var.name)
  kubernetes_version  = var.kubernetes_version

  addon_profile {
    kube_dashboard {
      enabled = false
    }

    azure_policy {
      enabled = true
    }
  }

  # To use SystemAssigned
  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = "172.17.0.1/16" #65534 hosts - 172.17.0.1 to 172.17.255.254
    load_balancer_sku  = var.load_balancer_sku
  }

  default_node_pool {
    name                 = var.agent_pool_name
    vm_size              = var.vm_size
    availability_zones   = var.availability_zones
    max_pods             = var.max_pods
    max_count            = var.max_count
    min_count            = var.min_count
    os_disk_size_gb      = var.os_disk_size_gb
    vnet_subnet_id       = azurerm_subnet.aks_subnet.id
    enable_auto_scaling  = var.enable_auto_scaling
    orchestrator_version = var.orchestrator_version
  }

  tags = merge(var.tags, local.module_tags)
}

resource "azurerm_role_assignment" "aks_subnet" {
  scope                = azurerm_subnet.aks_subnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.kubernetes_cluster.identity[0].principal_id
}