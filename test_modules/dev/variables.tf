variable "project_prefix" {
  type    = string
  default = "test"
}

variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "eks_subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "tags" {
  type = map(string)
  default = {
    env = "test"
  }
}

variable "grafana_admin_password" {
  type      = string
  sensitive = true
  default   = "Admin@12345"
}

variable "docdb_database_name" {
  type    = string
  default = "appdb"
}

variable "docdb_master_username" {
  type    = string
  default = "dbadmin"
}

variable "docdb_master_password" {
  type      = string
  sensitive = true
  default   = "ChangeMe123!"
}