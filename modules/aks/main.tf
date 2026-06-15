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
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.project_prefix}"
  location            = var.location
  resource_group_name = var.resource_group
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = "${var.project_prefix}-dns"

  default_node_pool {
    name            = "system"
    node_count      = var.agent_count
    vm_size         = var.agent_vm_size
    vnet_subnet_id  = var.subnet_id
    type            = "VirtualMachineScaleSets"
    os_disk_size_gb = 64
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true
  oidc_issuer_enabled               = true
  workload_identity_enabled         = true

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    dns_service_ip = var.dns_service_ip
    service_cidr   = var.service_cidr
  }

  # Optional container insights addon
  dynamic "oms_agent" {
    for_each = var.enable_container_insights ? [1] : []
    content {
      log_analytics_workspace_id = azurerm_log_analytics_workspace.law[0].id
    }
  }

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "law" {
  count               = var.enable_container_insights ? 1 : 0
  name                = "log-${var.project_prefix}"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

# (Optional) Add extensions (azure policy, open-service-mesh) if desired later.

