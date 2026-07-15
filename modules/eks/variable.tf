variable "project_prefix" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "node_count" {
  type    = number
  default = 2
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "subnet_ids" {
  type = list(string)
}

variable "enable_container_insights" {
  type    = bool
  default = true
}

variable "tags" {
  type = map(string)
}
