data "aws_iam_policy_document" "bucket_policy_doc_codepipeline_bucket" {
  statement {
    principals {
      type = "AWS"
      identifiers = [var.codepipeline_role_arn]
    }
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:ReplicateObject",
      "s3:PutObject",
      "s3:RestoreObject",
      "s3:PutObjectVersionTagging",
      "s3:PutObjectTagging",
      "s3:PutObjectAcl"
    ]

    resources = [
      aws_s3_bucket.codepipeline_s3_bucket.arn,
      "${aws_s3_bucket.codepipeline_s3_bucket.arn}/*"
    ]
  }
}


resource "aws_s3_bucket" "codepipeline_s3_bucket" {
  bucket_prefix = regex("[a-z0-9.-]+",lower(var.project_name))
  force_destroy = true
}

resource "aws_s3_bucket_acl" "codepipeline_s3_bucket_acl"{
  bucket = aws_s3_bucket.codepipeline_s3_bucket.id
  acl = "private"
}

resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_access" {
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "codepipeline_bucket_policy"{
  bucket = aws_s3_bucket.codepipeline_s3_bucket
  policy = data.aws_iam_policy_document.bucket_policy_doc_codepipeline_bucket.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_encryption"{
  bucket = aws_s3_bucket.codepipeline_s3_bucket.id
  

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_arn
      sse_algorithm = "aws:kms"
    }
  }
}