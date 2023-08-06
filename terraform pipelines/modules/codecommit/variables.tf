variable "source_repo_name" {
  default     = "my-terraform-app"
  description = "Specify the repo name if you need new one otherwise provide existing repo name"
  type        = string
}

variable "need_new_repo" {
  type        = bool
  default     = true
  description = "If you need a new repo specify true and provide name of repo in source_repo_name, if you already have a repo provide the name of repo in source_repo_name variable"
}

variable "source_branch_name" {
  default     = "main"
  description = "Define the default branch name of the repo"
  type        = string
}

variable "approval_pool_membersARN" {
  default     = "arn:aws:sts::123456789012:assumed-role/CodeCommitReview/*"
  description = "Provide the ARN of Role, group and user who will be responsible for the approval"
  type        = string
}


