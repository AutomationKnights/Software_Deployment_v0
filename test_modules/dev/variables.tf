variable "project_prefix" {
  type    = string
  default = "test"
}

variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "vnet_cidr" {
  type    = string
  default = "10.10.0.0/16"
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