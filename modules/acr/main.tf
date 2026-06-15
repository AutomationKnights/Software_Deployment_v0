terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azapi = {
      source = "azure/azapi"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}
resource "azurerm_container_registry" "acr" {
  name                = "${var.project_prefix}${var.location}acr"
  resource_group_name = var.resource_group
  location            = var.location
  sku                 = var.sku
  admin_enabled       = false
  tags                = var.tags
}
