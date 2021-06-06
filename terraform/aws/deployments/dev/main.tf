provider "aws" {
  region = var.region
}

locals {
  # Local variables for resource tags
  tag_creator    = "terraform"
  tag_tf_version = "0.15.5"
}

data "aws_caller_identity" "current" {}

# Create a S3 bucket
module "s3" {
  source                                       = "../../modules/s3/"
  bucket                                       = "${var.project_name}-aws-config-${var.region}-${var.stage}"
  acl                                          = "private"
  versioning_enabled                           = true
  lifecycle_rule_enabled                       = true
  lifecycle_rule_expiration                    = 365
  lifecycle_rule_noncurrent_version_expiration = 365

  tags = {
    creator    = local.tag_creator
    tf-version = local.tag_tf_version
    env        = var.stage
  }
}

# Set policies to S3 bucket for AWS Config (set up a bucket for the Configuration Recorder to write to)
module "s3_bucket_policy" {
  source = "../../modules/s3_bucket_policy/"
  bucket = module.s3.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AWSConfigBucketPermissionsCheck"
        Effect = "Allow"
        Principal : {
          Service : [
            "config.amazonaws.com"
          ]
        }
        Action = "s3:GetBucketAcl"
        Resource = [
          "${module.s3.arn}"
        ]
      },
      {
        Sid    = "AWSConfigBucketDelivery"
        Effect = "Allow"
        Principal : {
          Service : [
            "config.amazonaws.com"
          ]
        }
        Action = "s3:PutObject"
        Resource = [
          "${module.s3.arn}/AWSLogs/*"
        ]
      },
    ]
  })
}

# Create IAM rule for AWS Config (set up a role for the Configuration Recorder to use)
module "iam_role" {
  source = "../../modules/iam_role/"
  name   = "${var.project_name}-aws-config-${var.region}-${var.stage}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal : {
          Service : [
            "config.amazonaws.com"
          ]
        }
        Action = "sts:AssumeRole"
      },
    ]
  })

  tags = {
    creator    = local.tag_creator
    tf-version = local.tag_tf_version
    env        = var.stage
  }

}

# Create AWS Config
module "config" {
  source                                              = "../../modules/config/"
  name                                                = module.s3.id
  role_arn                                            = module.iam_role.arn
  recording_group_all_supported                       = true
  recording_group_include_global_resource_types       = true
  cdc_s3_bucket_name                                  = module.s3.id
  cdc_snapshot_delivery_properties_delivery_frequency = "TwentyFour_Hours"
  ccrs_is_enabled                                     = true
}

# Create a Security Hub
module "security_hub" {
  source = "../../modules/security_hub/"
}

# Create a GuardDuty
module "guardduty" {
  source           = "../../modules/guardduty/"
  admin_account_id = data.aws_caller_identity.current.account_id
}