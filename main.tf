terraform {
  required_version = ">=1.0.0"

  required_providers {
    aws = {
      required_version = ">=4.20.1"
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "rakesh-personal"
  region = "ap-southeast-2"
}

# Create S3 bucket to store the artifacts

module "codepipeline_bucket"{
  source = "./modules/s3"
  project_name = var.project_name
  aws_key_arn = module.kms_key.kms_arn
  codepipeline_role_arn = module.codepipeline_iam_role.arn
}


module "kms_key"{
  source = "./modules/KMS"
  codepipeline_role_arn = module.codepipeline_iam_role.arn
}

module "codepipeline_iam_role"{
  source = "./modules/IAM"
  create_new_role = var.create_new_role
  codepipeline_role_name =  var.create_new_role == true ? "${var.project_name}-codepipeline-role" : var.codepipeline_role_name
  s3_bucket_arn = module.codepipeline_bucket.arn
  kms_key_arn = module.kms_key.arn
  source_repository_name = var.source_repository_name
  }

module "codecommit_infra_source_repo"{
  source = "./modules/codecommit"
  source_repo_name = var.source_repository_name
  need_new_repo = var.need_new_repo
  source_branch_name = var.source_branch_name
  approval_pool_membersARN = var.approval_pool_membersARN

}

module "codebuild_projects"{
  source = "./modules/codebuild"
  depends_on = [
    module.codecommit_infra_source_repo
  ]
  project_name = var.project_name
  codebuild_projects = var.codebuild_projects
  service_role = module.codepipeline_iam_role.arn
  build_project_source = var.build_project_source
  codebuild_image = var.codebuild_image
  codebuild_compute_type = var.codebuild_compute_type
  build_env = var.build_env
  builder_image_pull_credentials_type = var.builder_image_pull_credentials_type
  build_artifact_type = var.build_artifact_type
  encryption_key = module.kms_key.arn
  tags = {
    Project_Name = var.project_name
    Environment = var.environment
    Account_ID = local.account_id
    Region = local.region
  }
}

module "codepipeline_terraform" {
  depends_on = [
    module.codebuild_projects,
    module.codecommit_infra_source_repo,
    module.codepipeline_bucket
  ]
  source = "./modules/codepipeline"
  codepipeline_role_arn = module.codepipeline_iam_role.arn
  project_name = var.project_name
  artifacts_bucket_name = module.codepipeline_bucket.id
  stages = var.stages
  kms_key_arn = var.kms_key_arn
  source_branch_name = var.source_branch_name
  source_repo_name = var.source_repo_name
}