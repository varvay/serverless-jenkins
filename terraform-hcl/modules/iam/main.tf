locals {
  tags = {
    "Product"     = var.product
    "Environment" = var.environment
  }
}

data "aws_caller_identity" "caller_identity" {}

# AWS managed policies
data "aws_iam_policy" "aws_managed_policy_AdministratorAccess" {
  name = "AdministratorAccess"
}

# User groups
resource "aws_iam_group" "iam_group_admin" {
  name = "admin"
  path = "/${var.product}/${var.environment}/"
}

# User group policy attachment
resource "aws_iam_group_policy_attachment" "iam_group_admin_policy_aws_managed_policy_AdministratorAccess" {
  group      = aws_iam_group.iam_group_admin.id
  policy_arn = data.aws_iam_policy.aws_managed_policy_AdministratorAccess.arn
}

# User
resource "aws_iam_user" "iam_user_varidVayaYusuf" {
  name          = "varid.vaya.yusuf"
  path          = "/${var.product}/${var.environment}/"
  force_destroy = true
  tags          = local.tags
}

# Group membership
resource "aws_iam_group_membership" "iam_group_membership_admin" {
  name  = "group-membership-admin"
  group = aws_iam_group.iam_group_admin.name
  users = [aws_iam_user.iam_user_varidVayaYusuf.name]
}
