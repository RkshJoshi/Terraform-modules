locals {
  region = data.aws_region.current
  account_id = data.aws_caller_identity.current.account_id
}