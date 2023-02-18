locals  {
  account_id = data.aws_caller_identity.current_account.account_id
}

resource "aws_kms_key" "KMS_key"{
  description = "KMS key for encryption"
  key_usage = "ENCRYPT_DECRYPT"
  is_enabled = true
  policy = data.aws_iam_policy_document.kms_policy_document.json
}