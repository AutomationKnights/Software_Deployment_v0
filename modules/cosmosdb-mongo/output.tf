# =========================================================
# Cosmos DB (MongoDB API) Outputs - Compatible with Azurerm v4.50+
# =========================================================

# 🔹 Cosmos DB Account Name
output "cosmosdb_account_name" {
  description = "The name of the Cosmos DB (MongoDB API) account."
  value       = azurerm_cosmosdb_account.mongo_account.name
}

# 🔹 Mongo Database Name
output "cosmosdb_database_name" {
  description = "The name of the Cosmos DB Mongo database."
  value       = azurerm_cosmosdb_mongo_database.mern_db.name
}

# =========================================================
# ✅ Securely fetch Cosmos DB connection strings using new data source
# =========================================================
data "azapi_resource_action" "cosmosdb_list_keys" {
  type        = "Microsoft.DocumentDB/databaseAccounts@2024-05-15"
  resource_id = azurerm_cosmosdb_account.mongo_account.id
  action      = "listKeys"
  method      = "POST"
}

locals {
  primary_master_key   = jsondecode(data.azapi_resource_action.cosmosdb_list_keys.output).primaryMasterKey
  secondary_master_key = jsondecode(data.azapi_resource_action.cosmosdb_list_keys.output).secondaryMasterKey

  mongo_connection_string = "mongodb://${azurerm_cosmosdb_account.mongo_account.name}:${local.primary_master_key}@${azurerm_cosmosdb_account.mongo_account.name}.mongo.cosmos.azure.com:10255/${azurerm_cosmosdb_mongo_database.mern_db.name}?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${azurerm_cosmosdb_account.mongo_account.name}@"
}

# 🔹 Primary Key
output "primary_master_key" {
  description = "Primary master key for Cosmos DB Mongo API."
  value       = local.primary_master_key
  sensitive   = true
}

# 🔹 Secondary Key
output "secondary_master_key" {
  description = "Secondary master key for Cosmos DB Mongo API."
  value       = local.secondary_master_key
  sensitive   = true
}

# 🔹 Connection String
output "cosmosdb_connection_string" {
  description = "MongoDB connection string for Cosmos DB Mongo API."
  value       = local.mongo_connection_string
  sensitive   = true
}