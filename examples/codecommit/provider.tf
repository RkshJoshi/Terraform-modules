provider "aws"{
  region = "ap-southeast-2"
  profile = "rakesh-personal"
}

terraform {
  backend "s3" {
    bucket = "rksh-terraform-state-ap-southeast-2"
    key = "codepipeline/codecommit.tf"
    dynamodb_table = "rksh-terraform-table-"
  }
}