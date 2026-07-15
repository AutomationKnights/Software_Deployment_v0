output "name" { value = azurerm_kubernetes_cluster.aks.name }
output "kube_config" {
  value = {
    host                   = azurerm_kubernetes_cluster.aks.kube_config[0].host
    client_certificate     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  }
  sensitive = true
}

output "kubelet_principal_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
