locals {
  module_name = "s3_bucket"

  module_tags = {
    module-name = local.module_name
  }
}

# Create a S3 bucket
resource "aws_s3_bucket" "s3_bucket" {
  # checkov:skip=CKV2_AWS_6: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AWS_18: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AWS_19: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AWS_21: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AWS_52: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AWS_144: "Since this is just a demo this check will be ignored"
  # checkov:skip=CKV_AWS_145: "Since this is just a demo this check will be ignored"

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

