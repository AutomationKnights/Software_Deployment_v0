terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_secretsmanager_secret" "grafana" {
  name = coalesce(var.name, "secret-${var.project_prefix}-grafana-admin-password")
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "grafana" {
  secret_id     = aws_secretsmanager_secret.grafana.id
  secret_string = var.grafana_admin_password
}