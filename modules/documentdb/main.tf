terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

resource "random_password" "master_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_docdb_subnet_group" "default" {
  name       = "${var.name_prefix}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "${var.name_prefix}-cluster"
  engine                  = "docdb"
  master_username         = "adminuser"
  master_password         = random_password.master_password.result
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = aws_docdb_subnet_group.default.name
  tags                    = var.tags
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = "${var.name_prefix}-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = "db.t3.medium"
  tags               = var.tags
}