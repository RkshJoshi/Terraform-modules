output "source_repo_clone_http_url" {
  value       = var.need_new_repo ? aws_codecommit_repository.new_terraform_repo[0].clone_url_http : data.aws_codecommit_repository.existing_source_repo[0].clone_url_http
  description = "List the repo HTTP URL for cloning"
}

output "source_repository_name" {
  value       = var.need_new_repo ? aws_codecommit_repository.new_terraform_repo[0].repository_name : data.aws_codecommit_repository.existing_source_repo[0].repository_name
  description = "Name of the source repository name"
}

output "source_repository_arn" {
  value = var.need_new_repo ? aws_codecommit_repository.new_terraform_repo[0].arn : data.aws_codecommit_repository.existing_source_repo[0].arn
}