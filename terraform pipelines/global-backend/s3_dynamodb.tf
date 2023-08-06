data "aws_region" "current"{}

resource "aws_s3_bucket" "my_terraform_remote_state"{
  bucket = "rksh-terraform-state-${data.aws_region.current.name}"
}

resource "aws_dynamodb_table" "my_terraform_lock"{
  name = "rksh-terraform-lock-${data.aws_region.current.name}"
  billing_mode = "PROVISIONED"
  read_capacity = 1
  write_capacity = 1
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}