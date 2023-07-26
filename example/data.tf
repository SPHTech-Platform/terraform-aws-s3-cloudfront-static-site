##############
# S3 additional policy
###############
data "aws_iam_policy_document" "s3_policy_additional" {
  statement {
    actions = ["s3:GetObject"]
    resources = ["${module.s3_test_static.s3_bucket_arn}/*",
    "${module.s3_test_static.s3_bucket_arn}"]
    principals {
      type        = "AWS"
      identifiers = module.s3_test_static.cloudfront_origin_access_identity_iam_arns
    }
  }

  depends_on = [
    module.s3_test_static.cloudfront_distribution_id
  ]
}
