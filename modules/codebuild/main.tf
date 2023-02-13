resource "aws_codebuild_project" "codebuild_project"{
  count = var.no_of_codebuild_projects
  description = "test-codebuild-project to validate pipeline"
}