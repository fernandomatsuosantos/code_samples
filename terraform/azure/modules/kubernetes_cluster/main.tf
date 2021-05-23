# Read data from the current subscription for later use
data "azurerm_subscription" "primary" {}

# Create an AKS cluster
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = lower(var.name)

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      windows_profile
    ]
  }

  linux_profile {
    admin_username = "poc-admin"

    # SSH key is generated using "tls_private_key" resource
    ssh_key {
      key_data = tls_private_key.ssh.public_key_openssh
    }
  }

  default_node_pool {
    name       = var.agent_pool_name
    vm_size    = var.vm_size
    node_count = var.node_count
  }
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key" {
  content  = tls_private_key.ssh.private_key_pem
  filename = "./private_ssh_key"
}

