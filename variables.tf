variable "project_name"{
  type = string
  description = "Name of the codebuild Project"
}

variable "create_new_role"{
  type = bool
}

variable "codepipeline_role_name"{
  type = string
}

variable "s3_bucket_arn"{
  type = string
}

variable "kms_key_arn"{
  type = string
}


variable "source_repository_name"{
  type = string
}

variable "need_new_repo" {
  type        = bool
  description = "If you need a new repo specify true and provide name of repo in source_repo_name, if you already have a repo provide the name of repo in source_repo_name variable"
}

variable "source_branch_name" {
  description = "Define the default branch name of the repo"
  type        = string
}

variable "approval_pool_membersARN" {
  default     = "arn:aws:sts::123456789012:assumed-role/CodeCommitReview/*"
  description = "Provide the ARN of Role, group and user who will be responsible for the approval"
  type        = string
}

#Codebuild

variable "project_name" {
  type= string
}

variable "codebuild_projects"{
  type = list(string)
  default = ["validate","Plan","Apply"]
}

variable "service_role"{
  type = string
  description = "Provide the ARN for the code build service role"
}

variable "build_project_source"{
  type = string
  description = "Provide the source which will be used for build"
}

variable "codebuild_image"{
  type = string
  description = "Provide the codebuild imgae to use for the build projects"
}

variable "codebuild_compute_type" {
  type = string
  description = "specify the type of compute you want to use to run your builds"
}

variable "build_env"{
  type = string
  description = "Specify the build envrionment required for the related builds"
}

variable "builder_image_pull_credentials_type"{
  type = string
  description = "Type of credential AWS uses to pull images in your build"
}

variable "build_artifact_type"{
  type = string
  description = "Provide te build output artifacts type"
}

variable "encryption_key" {
  type = string
  description = "provide the encryption key ARN that will be used for the builds"
}

variable "tags" {
  type = map(any)
}


#codepipeline variables
variable "stages"{
  description = "List of Map containing information about the stages of the codepipeline"
  type = list(map(any))
}

variable "kms_key_arn"{
  description = "KMS key used to encrypt the bucket"
  type = string
}


