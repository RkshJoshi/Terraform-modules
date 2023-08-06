output "id"{
  description = "The id of the codepipeline"
  value = aws_codepipeline.codepipeline.id
}

output "arn"{
  description = "The ARN of codepipeline"
  value = aws_codepipeline.codepipeline.arn
  }

output "name"{
  description = "Name of codepipeline"
  value =aws_codepipeline.codepipeline.name
}