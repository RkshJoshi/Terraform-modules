locals {
  commonTags = {
    Environment = var.envName
    AppName = "OpenData"
  }  
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms_policy_doc"{
  statement {
    sid = "AllowAccesstoIAM"
    actions = [
      "kms:*"
    ]
    resources = ["*"]
    effect = "Allow"
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type = "AWS"
    }
  }
  statement {
    sid = "AllowAccesstoKMS"
    actions = [
      "kms:GenerateDataKey"
    ]
    effect = "Allow"
    resources = ["*"]
    principals {
      identifiers = ["pullthroughcache.ecr.amazonaws.com",
      "replication.ecr.amazonaws.com"]
      type = "Service"
    }
  }
  } 

# resource "aws_iam_policy" "ckan_kms_policy" {
#   policy = data.aws_iam_policy_document.kms_policy_doc.json
# }

resource "aws_kms_key" "ckan_kms_key"{
  description = "KMS key for CKAN"
  deletion_window_in_days = 7
  is_enabled = true
  key_usage = "ENCRYPT_DECRYPT"
  policy = data.aws_iam_policy_document.kms_policy_doc.json
  tags = local.commonTags
}

resource "aws_ecr_repository" "ecr_repo" {
  for_each = var.repoName
  name = "${each.key}-${var.envName}-repo"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
  encryption_configuration {
    encryption_type = "KMS"
    kms_key = aws_kms_key.ckan_kms_key.arn
  }
  tags = local.commonTags
}