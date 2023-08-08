output "kmsKeyArn" {
  value = aws_kms_key.ckan_kms_key.arn
  description = "KMS key ARN"
}

output "kmsKeyId" {
  value = aws_kms_key.ckan_kms_key.key_id
  description = "KeyId of KMS key"
}

output "repoURIs" {
  value = {
    for repo_name, repo_config in aws_ecr_repository.ecr_repo :
    repo_name => repo_config.repository_url
  }
  description = "URIs of Repositories"
}