output "name" { value = aws_eks_cluster.this.name }

output "kube_config" {
  value = {
    host                   = aws_eks_cluster.this.endpoint
    cluster_ca_certificate = aws_eks_cluster.this.certificate_authority[0].data
  }
  sensitive = true
}

output "node_role_arn" {
  value = aws_iam_role.node.arn
}
