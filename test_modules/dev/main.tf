module "ecr" {
  source         = "../../modules/ecr"
  project_prefix = var.project_prefix
  tags           = var.tags
}

module "vpc" {
  source          = "../../modules/network"
  project_prefix  = var.project_prefix
  vpc_cidr        = var.vpc_cidr
  eks_subnet_cidr = var.eks_subnet_cidr
  tags            = var.tags
}

module "eks" {
  source                    = "../../modules/eks"
  project_prefix            = var.project_prefix
  subnet_ids                = module.vpc.eks_subnet_ids
  kubernetes_version        = "1.30"
  node_count                = 2
  instance_type             = "t3.medium"
  enable_container_insights = true
  tags                      = var.tags
}

module "secrets_manager" {
  source                 = "../../modules/secrets-manager"
  project_prefix         = var.project_prefix
  tags                   = var.tags
  grafana_admin_password = var.grafana_admin_password
}

module "documentdb" {
  source              = "../../modules/documentdb"
  project_prefix      = var.project_prefix
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.eks_subnet_ids
  database_name       = var.docdb_database_name
  master_username     = var.docdb_master_username
  master_password     = var.docdb_master_password
  allowed_cidr_blocks = [var.vpc_cidr]
  tags                = var.tags
}

module "monitoring" {
  source         = "../../modules/monitoring"
  project_prefix = var.project_prefix
  enable_ingress = true
  tags           = var.tags
}
