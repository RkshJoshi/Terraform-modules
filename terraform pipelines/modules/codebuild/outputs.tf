output "id"{
  value = aws_codebuild_project.codebuild_project[*].id
  description = "List the ids of codebuild project"
}

output "name"{
  value = aws_codebuild_project.codebuild_project[*].name
  description = "List the name of codebuild projects"
}

output "arn"{
  value = aws.codebuild_project.codebuild_project[*].arn
  description = "List the ARNs of codebuild projects"
}