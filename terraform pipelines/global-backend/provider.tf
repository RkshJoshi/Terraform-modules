provider "aws"{
  region = "ap-southeast-2"
}

# terraform {
#   backend "s3"{
#     bucket = "rksh-terraform-state-${data.aws_region.current}"
#     key = var.backend_key
#     region = "ap-southeast-2"
#     dynamodb_table  = "rksh-terraform-lock-${data.aws_region.current}"
#     encrypt = true
#   }
# }