terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {
  secret_name = coalesce(var.name, "${var.project_prefix}/grafana-admin-password")
}

resource "aws_secretsmanager_secret" "this" {
  name        = local.secret_name
  description = "Grafana admin password"
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.grafana_admin_password
}
