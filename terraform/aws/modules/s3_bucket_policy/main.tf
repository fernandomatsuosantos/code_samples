# Apply policies to S3 buckets
resource "aws_s3_bucket_policy" "config_bucket_policy" {
  bucket = var.bucket
  policy = var.policy
}