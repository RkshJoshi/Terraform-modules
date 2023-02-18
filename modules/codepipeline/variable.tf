variable "codepipeline_role_arn" {
  type=string
}

variable "project_name"{
  type = string
}

variable "artifacts_bucket_name" {
  type=string
}

variable "stages"{
  description = "List of Map containing information about the stages of the codepipeline"
  type = list(map(any))
}

variable "kms_key_arn"{
  description = "KMS key used to encrypt the bucket"
  type = string
}

variable "source_branch_name"{
  type = string
  description = "The Source branch Name"
}

variable "source_repo_name"{
  type = string
  description = "Source Repo name"
}

