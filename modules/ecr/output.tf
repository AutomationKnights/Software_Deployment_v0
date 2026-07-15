output "repository_url" {
  value = aws_ecr_repository.ecr.repository_url
}

output "repository_name" {
  value = aws_ecr_repository.ecr.name
}

output "registry_id" {
  value = aws_ecr_repository.ecr.registry_id
}
