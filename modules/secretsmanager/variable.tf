variable "project_prefix" { type = string }
variable "location" { type = string }
variable "name" {
  type    = string
  default = null
}
variable "tags" { type = map(string) }
variable "grafana_admin_password" { type = string }
