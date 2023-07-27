module "s3" {
  #checkov:skip=CKV_TF_1:Ensure Terraform module sources use a commit hash
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.5.0"

  create_bucket           = var.create_bucket
  bucket                  = var.bucket_name
  acl                     = var.acl
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets

  server_side_encryption_configuration = var.server_side_encryption_configuration
  cors_rule                            = var.cors_rule
  lifecycle_rule                       = var.lifecycle_rule

  versioning = var.versioning
  logging    = var.logging

  website = var.website
}


resource "aws_s3_bucket_policy" "docs" {
  count   = module.s3.s3_bucket_id ? 1 : 0
  bucket  = module.s3.s3_bucket_id
  policy  = data.aws_iam_policy_document.s3_policy_merge.json

  depends_on = [
    module.cdn.cloudfront_distribution_id
  ]
}
