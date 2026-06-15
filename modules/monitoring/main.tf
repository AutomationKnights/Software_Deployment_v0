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
locals {
  namespace_monitoring = "monitoring"
  namespace_ingress    = "ingress-nginx"
}

resource "kubernetes_namespace" "monitoring" {
  metadata { name = local.namespace_monitoring }
}

resource "kubernetes_namespace" "ingress" {
  count = var.enable_ingress ? 1 : 0
  metadata { name = local.namespace_ingress }
}

# NOTE: Helm releases intentionally removed to avoid provider kubeconfig complexity in this pure Terraform code sample.
# You can reintroduce helm_release resources once root helm provider is configured properly.