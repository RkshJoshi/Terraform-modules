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