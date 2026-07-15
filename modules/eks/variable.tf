variable "project_prefix" { type = string }
variable "location" { type = string }
variable "kubernetes_version" {
  type    = string
  default = "1.31"
}
variable "agent_count" {
  type    = number
  default = 2
}
variable "agent_vm_size" {
  type    = string
  default = "t2.micro"
}
variable "subnet_ids" { type = list(string) }
variable "acr_id" {
  type    = string
  default = null
}
variable "service_cidr" { type = string }
variable "dns_service_ip" { type = string }
variable "enable_container_insights" {
  type    = bool
  default = true
}
variable "tags" { type = map(string) }