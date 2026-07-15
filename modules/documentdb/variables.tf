variable "name_prefix" {
  type        = string
  description = "Prefix for DocumentDB cluster name"
  default     = "docdb"
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}