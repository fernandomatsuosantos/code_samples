locals {
  module_name = "s3_bucket"

  module_tags = {
    module-name = local.module_name
  }
}

# Create a S3 bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket
  acl    = var.acl

  versioning {
    enabled = var.versioning_enabled
  }

  lifecycle_rule {
    enabled = var.lifecycle_rule_enabled

    expiration {
      days = var.lifecycle_rule_expiration
    }

    noncurrent_version_expiration {
      days = var.lifecycle_rule_noncurrent_version_expiration
    }
  }

  tags = merge(var.tags, local.module_tags)

}

