output "id" {
  value = aws_s3_bucket.codepipeline_s3_bucket.bucket
  description = "The name of the S3 bucket"
}

output "arn"{
  value = aws_s3_bucket.codepipeline_s3_bucket.arn
  description = "ARN of the S3 bucket"
}

output "bucket_url" {
  value       = "https://s3.console.aws.amazon.com/s3/buckets/${aws_s3_bucket.codepipeline_s3_bucket.bucket}?region=${aws_s3_bucket.codepipeline_s3_bucket.region}&tab=objects"
  description = "The URL of the S3 Bucket"
}
