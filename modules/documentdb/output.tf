output "cluster_id" {
  value = aws_docdb_cluster.mongo_account.id
}

output "cluster_endpoint" {
  value = aws_docdb_cluster.mongo_account.endpoint
}

output "reader_endpoint" {
  value = aws_docdb_cluster.mongo_account.reader_endpoint
}

output "connection_string" {
  value     = local.mongo_connection_string
  sensitive = true
}
