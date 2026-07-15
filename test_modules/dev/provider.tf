terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0.0"
  backend "azurerm" {
    resource_group_name  = "terraform-backend"
    storage_account_name = "terraformbackendv02"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
  # client_id       = "<client_id>"
  # client_secret   = " <client_secret>"
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

}
