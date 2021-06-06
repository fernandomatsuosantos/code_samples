# output "subnet_id" {
#   value = azurerm_subnet.aks_subnet.id
# }

output "name" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.name
}
