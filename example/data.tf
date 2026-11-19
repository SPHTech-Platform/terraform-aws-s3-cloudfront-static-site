##############
# S3 additional policy
###############
data "aws_iam_policy_document" "s3_policy_additional" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = [module.s3_test_static.s3_bucket_arn]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [module.s3_test_static.cloudfront_distribution_arn]
    }
  }

  depends_on = [
    module.s3_test_static.cloudfront_distribution_id
  ]
}
