variable "project_prefix" { type = string }
variable "resource_group" { type = string }
variable "enable_ingress" {
  type    = bool
  default = true
}
variable "grafana_admin_password" {
  type    = string
  default = null
}
variable "tags" { type = map(string) }
