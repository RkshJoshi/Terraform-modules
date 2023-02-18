resource "aws_codebuild_project" "codebuild_project"{
  count = len(var.codebuild_projects)

  name = "${var.project_name}-${var.build_projects[count.index]}"
  service_role = var.service_role
  encryption_key = var.encryption_key
  tags = var.tags
  
  artifacts {
    type = var.build_artifact_type
    
  }
  environment {
    compute_type = var.codebuild_compute_type
    image = var.codebuild_image
    type = var.build_env
    privileged_mode = false
    image_pull_credentials_type = var.builder_image_pull_credentials_type
    
  }
  source {
    type = var.build_project_source
    buildspec = "./templates/buildspec_${var.build_projects[count.index]}"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }
}