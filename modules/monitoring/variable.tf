variable "project_prefix" { type = string }

variable "enable_ingress" {
  type    = bool
  default = true
}

variable "tags" { type = map(string) }
