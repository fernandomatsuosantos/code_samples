output "pip_name" {
  value = var.pip_name
}

output "subnet_id" {
  value = azurerm_subnet.subnet_waf.id
}
