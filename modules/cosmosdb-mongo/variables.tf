variable "name_prefix" {
  type        = string
  description = "Prefix for cosmos account name; random suffix appended"
  default     = "cosmosmongo"
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "database_name" {
  type = string
}

variable "throughput" {
  type    = number
  default = 400
}

variable "create_collection" {
  type    = bool
  default = true
}

variable "collection_name" {
  type    = string
  default = "products"
}

variable "default_ttl_seconds" {
  type    = number
  default = -1
}

variable "shard_key" {
  type    = string
  default = "_id"
}

variable "index_keys" {
  type    = list(string)
  default = ["_id"]
}

variable "consistency_level" {
  type    = string
  default = "Session"
}

variable "enable_free_tier" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}