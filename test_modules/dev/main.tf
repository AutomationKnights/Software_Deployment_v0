module "acr" {
  source         = "../../modules/acr"
  project_prefix = var.project_prefix
  resource_group = var.resource_group
  location       = var.location
  tags = {
    "env" = "test"
  }

}
module "vnet" {
  source          = "../../modules/network"
  project_prefix  = var.project_prefix
  resource_group  = var.resource_group
  location        = var.location
  vnet_cidr       = var.vnet_cidr
  aks_subnet_cidr = var.aks_subnet_cidr
  tags            = var.tags
}
module "aks" {
  source                    = "../../modules/aks"
  project_prefix            = var.project_prefix
  resource_group            = var.resource_group
  subnet_id                 = module.vnet.aks_subnet_id
  location                  = var.location
  kubernetes_version        = "1.36.0"
  agent_count               = 2
  agent_vm_size             = "Standard_D2s_v3"
  acr_id                    = module.acr.id
  enable_container_insights = true
  tags                      = var.tags
  dns_service_ip            = var.dns_service_ip
  service_cidr              = var.service_cidr

}

module "keyvault" {
  source                 = "../../modules/keyvault"
  resource_group         = var.resource_group
  project_prefix         = var.project_prefix
  location               = var.location
  tags                   = var.tags
  grafana_admin_password = "Admin@12345"
}