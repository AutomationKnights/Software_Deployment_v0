variable "project_prefix" {
  type = string
}
variable "resource_group" {
  type = string
}
variable "location" {
  type = string
}
variable "name" {
  type    = string
  default = null
}
variable "sku" {
  type    = string
  default = "Basic"
}
variable "tags" {
  type = map(string)

}