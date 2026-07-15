terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {
  cluster_name = "${var.project_prefix}-docdb"
}

resource "aws_security_group" "docdb" {
  name        = "${local.cluster_name}-sg"
  description = "Security group for DocumentDB"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.allowed_cidr_blocks
    content {
      from_port   = var.port
      to_port     = var.port
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${local.cluster_name}-sg"
  })
}

resource "aws_docdb_subnet_group" "docdb" {
  name       = "${local.cluster_name}-subnets"
  subnet_ids = var.subnet_ids

  tags = var.tags
}

resource "aws_docdb_cluster" "mongo_account" {
  cluster_identifier     = local.cluster_name
  engine                 = "docdb"
  master_username        = var.master_username
  master_password        = var.master_password
  port                   = var.port
  db_subnet_group_name   = aws_docdb_subnet_group.docdb.name
  vpc_security_group_ids = [aws_security_group.docdb.id]
  skip_final_snapshot    = true
  apply_immediately      = true

  tags = var.tags
}

resource "aws_docdb_cluster_instance" "mern_db" {
  count              = var.cluster_size
  identifier         = "${local.cluster_name}-${count.index + 1}"
  cluster_identifier = aws_docdb_cluster.mongo_account.id
  instance_class     = var.instance_class
  apply_immediately  = true

  tags = var.tags
}

locals {
  mongo_connection_string = "mongodb://${var.master_username}:${var.master_password}@${aws_docdb_cluster.mongo_account.endpoint}:${var.port}/${var.database_name}?tls=true&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false"
}
