locals {
  module_name = "iam_role"

  module_tags = {
    module-name = local.module_name
  }
}

# Create an IAM role
resource "aws_iam_role" "iam_role" {
  name               = var.name
  assume_role_policy = var.assume_role_policy

  tags = merge(var.tags, local.module_tags)
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}