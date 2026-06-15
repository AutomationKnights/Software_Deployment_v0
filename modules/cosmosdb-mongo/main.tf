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


resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

resource "azurerm_cosmosdb_account" "mongo_account" {
  name                = "${var.name_prefix}${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "MongoDB"

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level = var.consistency_level
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  free_tier_enabled = var.enable_free_tier
  tags              = var.tags
}

resource "azurerm_cosmosdb_mongo_database" "mern_db" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.mongo_account.name
  throughput          = var.throughput
}

resource "azurerm_cosmosdb_mongo_collection" "mern_collection" {
  count               = var.create_collection ? 1 : 0
  name                = var.collection_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.mongo_account.name
  database_name       = azurerm_cosmosdb_mongo_database.mern_db.name
  default_ttl_seconds = var.default_ttl_seconds
  shard_key           = var.shard_key

  index {
    keys = var.index_keys
  }
}