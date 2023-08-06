data "aws_codecommit_repository" "existing_source_repo" {
  count = var.need_new_repo ? 0 : 1
  repository_name = var.source_repo_name
}