module "ecr" {
  source         = "../../modules/ecr"
  project_prefix = var.project_prefix
  location       = var.region
  tags = {
    "env" = "test"
  }
}

module "vpc" {
  source         = "../../modules/vpc"
  project_prefix = var.project_prefix
  region         = var.region
  vnet_cidr      = var.vnet_cidr
  tags           = var.tags
}

module "eks" {
  source                    = "../../modules/eks"
  project_prefix            = var.project_prefix
  subnet_ids                = module.vpc.subnet_ids
  location                  = var.region
  kubernetes_version        = "1.31"
  agent_count               = 2
  agent_vm_size             = "t3.medium"
  acr_id                    = module.ecr.registry_id
  enable_container_insights = true
  tags                      = var.tags
  dns_service_ip            = var.dns_service_ip
  service_cidr              = var.service_cidr
}

module "secretsmanager" {
  source                 = "../../modules/secretsmanager"
  project_prefix         = var.project_prefix
  location               = var.region
  tags                   = var.tags
  grafana_admin_password = "Admin@12345"
}