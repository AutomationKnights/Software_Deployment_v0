project_prefix  = "sd1"
resource_group  = "rg-sd1"
location        = "centralindia"
vnet_cidr       = "10.0.0.0/16"
aks_subnet_cidr = "10.0.0.0/24"
tags = {
  "env"   = "test"
  "owner" = "mdakbar"
}
service_cidr   = "10.200.0.0/24"
dns_service_ip = "10.200.0.10"
