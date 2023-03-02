# Adding more comments here to make sure that Pull request is created without any issues.

resource "aws_codepipeline" "codepipeline" {
  name = "${var.project_name}-codepipeline"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.artifacts_bucket_name 
    type = "S3"
    encryption_key {
      id = var.kms_key_arn
      type = "KMS"
    }
  }
  stage {
    name = "Source"
    action {
      category = "Source"
      owner = "AWS"
      name = "Download-Source"
      provider = "CodeCommit"
      namespace = "SourceVariables"
      output_artifacts = ["SourceOutput"]
      run_order = 1

      configuration = {
        RepositoryName = var.source_repo_name
        BranchName = var.source_branch_name
        PollForSourceChanges = "true"
      }
     }
  }

  dynamic "stage"{
    for_each = var.stages

    content {
      name = "Stage-${stage.value["name"]}"
      action {
        category = stage.value["category"]
        name = "Action-${stage.value["name"]}"
        owner = stage.value["owner"]
        provider = stage.value["provider"]
        version = "1"
        input_artifacts = [stage.value["input_artifacts"]]
        output_artifacts = [stage.value["output_artifacts"]]
        run_order = index(var.stages, stage.value)+2

        configuration = {
          ProjectName = stage.value["provider"] == "CodeBuild" ?"${var.project_name}"-"${stage.value["name"]}" : null
        } 
      }
    }
  }
}