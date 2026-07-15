variable "project_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "database_name" {
  type = string
}

variable "master_username" {
  type = string
}

variable "master_password" {
  type      = string
  sensitive = true
}

variable "instance_class" {
  type    = string
  default = "db.t3.medium"
}

variable "cluster_size" {
  type    = number
  default = 1
}

variable "port" {
  type    = number
  default = 27017
}

variable "allowed_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
