terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {
  monitoring_log_group_name = "/aws/eks/${var.project_prefix}/monitoring"
  ingress_log_group_name    = "/aws/eks/${var.project_prefix}/ingress-nginx"
}

resource "aws_cloudwatch_log_group" "monitoring" {
  name              = local.monitoring_log_group_name
  retention_in_days = 30

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "ingress" {
  count             = var.enable_ingress ? 1 : 0
  name              = local.ingress_log_group_name
  retention_in_days = 30

  tags = var.tags
}
