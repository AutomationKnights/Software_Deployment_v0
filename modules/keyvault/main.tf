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

data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "kv" {
  name                       = coalesce(var.name, replace("kv-${var.project_prefix}", "-", ""))
  location                   = var.location
  resource_group_name        = var.resource_group
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
  enable_rbac_authorization  = true
  tags                       = var.tags
}

# Assign RBAC role to the Service Principal running Terraform
resource "azurerm_role_assignment" "kv_secrets_officer" {
  count                            = var.assign_rbac_to_current_principal ? 1 : 0
  scope                            = azurerm_key_vault.kv.id
  role_definition_name             = var.key_vault_role_name
  principal_id                     = data.azurerm_client_config.current.object_id
  skip_service_principal_aad_check = true

  # Ensure role assignment happens only after Key Vault creation
  depends_on = [azurerm_key_vault.kv]
}

# Wait for RBAC role propagation (so secret creation doesn’t fail)
resource "time_sleep" "wait_for_rbac" {
  depends_on      = [azurerm_role_assignment.kv_secrets_officer]
  create_duration = "60s" # Wait for 1 minute (recommended)
}

# Create Grafana admin password secret
resource "azurerm_key_vault_secret" "grafana" {
  name         = "grafana-admin-password"
  value        = var.grafana_admin_password
  key_vault_id = azurerm_key_vault.kv.id

  # Wait for role assignment before creating secret
  depends_on = [time_sleep.wait_for_rbac]
}

# Outputs are moved to `output.tf`