variable "project_prefix" {
  type    = string
  default = "test"
}

variable "resource_group" {
  type    = string
  default = "rg-terraform"
}

variable "location" {
  type    = string
  default = "centralindia"
}

variable "vnet_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "aks_subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "tags" {
  type = map(string)
  default = {
    env = "test"
  }

}
variable "dns_service_ip" {
  type = string
}
variable "service_cidr" {
  type = string
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID used by the provider and supplied through Azure DevOps."
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID used by the provider and supplied through Azure DevOps."
}