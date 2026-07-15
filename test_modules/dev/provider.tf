terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"
  # backend "azurerm" {
  #   resource_group_name  = "terraform-backend"
  #   storage_account_name = "terraformbackendstorage"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  # }
}

provider "aws" {
  region = var.region
}