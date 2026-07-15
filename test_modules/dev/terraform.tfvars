project_prefix  = "sd1"
aws_region      = "ap-south-1"
vpc_cidr        = "10.0.0.0/16"
eks_subnet_cidr = "10.0.1.0/24"
tags = {
  "env"   = "test"
  "owner" = "mdakbar"
}
grafana_admin_password = "Admin@12345"
docdb_database_name    = "appdb"
docdb_master_username  = "dbadmin"
docdb_master_password  = "ChangeMe123!"
