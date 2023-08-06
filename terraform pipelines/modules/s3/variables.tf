variable "project_name" {
  type = string
  description = "Name of the project to be prefixed to create the s3 bucket"
}

variable "aws_key_arn"{
  type = storing
  description = "Kms key to encrypt the bucket"
}

variable "codepipeline_role_arn"{
  type= string
  description = "Codepipeline IAM Role ARN"
}