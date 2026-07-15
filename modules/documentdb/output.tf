output "cluster_endpoint" {
  value = aws_docdb_cluster.docdb.endpoint
}

output "cluster_reader_endpoint" {
  value = aws_docdb_cluster.docdb.reader_endpoint
}

output "master_username" {
  value = aws_docdb_cluster.docdb.master_username
}

output "master_password" {
  value     = aws_docdb_cluster.docdb.master_password
  sensitive = true
}

output "connection_string" {
  value     = "mongodb://${aws_docdb_cluster.docdb.master_username}:${aws_docdb_cluster.docdb.master_password}@${aws_docdb_cluster.docdb.endpoint}:27017/?tls=true&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false"
  sensitive = true
}