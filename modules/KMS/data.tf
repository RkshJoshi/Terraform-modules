data "aws_region" "current_region"{}
data "aws_caller_identity" "current_account"{
}

data "aws_iam_policy_document" "codebuild_KMS_permission"{
  statement {
    sid = "Enable IAM user permission"
    effect = "Allow"
    actions = ["kms:*"]
    resources = ["*"]
    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam:${local.account_id}:root"]
    }
  }

  statement {
    sid ="Allow access for key administrator"
    effect = "Allow"
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion"
    ]
    resources = ["*"]
    principals {
      type = "AWS"
      identifiers = [var.codepipeline_role_arn]
    }
  }

  statement {
    sid ="Allow use of the key"
    effect="Allow"
    actions =[
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    principals {
      type = "AWS"
      identifiers = [var.codepipeline_role_arn]
    }
  }

  statement {
    sid = "Allow attachment of persistent resources "
    effect = "Allow"
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]
    principals {
      type = "AWS"
      identifiers = [
        var.codepipeline_role_arn
      ]
    }
    condition {
      test = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values =["true"]
    }
  }
}