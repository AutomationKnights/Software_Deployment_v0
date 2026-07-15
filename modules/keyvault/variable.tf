variable "project_prefix" { type = string }
variable "resource_group" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

variable "grafana_admin_password" {
  type = string
}

variable "name" {
  type    = string
  default = null
}

variable "assign_rbac_to_current_principal" {
  type        = bool
  default     = true
  description = "Assigns the current Azure principal RBAC on the Key Vault."
}

variable "key_vault_role_name" {
  type        = string
  default     = "Key Vault Secrets Officer"
  description = "RBAC role to assign to the current principal on the Key Vault."
}
