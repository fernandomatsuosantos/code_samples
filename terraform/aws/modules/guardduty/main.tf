locals {
  module_name = "guardduty_detector"

  module_tags = {
    module-name = local.module_name
  }
}

# Create a GuardDuty
resource "aws_guardduty_detector" "guardduty_detector" {
  # checkov:skip=CKV2_AWS_3: "Since this is just a demo this check will be ignored"

  enable = true

  tags = merge(var.tags, local.module_tags)
}
