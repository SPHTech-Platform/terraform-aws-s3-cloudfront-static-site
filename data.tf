data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.s3.s3_bucket_arn}/*"]
    principals {
      type        = "AWS"
      identifiers = module.cdn.cloudfront_origin_access_identity_iam_arns
    }
  }
  depends_on = [
    module.cdn.cloudfront_distribution_id
  ]
}

data "aws_iam_policy_document" "s3_policy_merge" {

  source_policy_documents = [
    data.aws_iam_policy_document.s3_policy.json,
    var.policy
  ]
}
