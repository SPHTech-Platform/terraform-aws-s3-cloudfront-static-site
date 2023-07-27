data "aws_region" "current" {}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions = ["s3:GetObject"]
    resources = [
      "${module.s3.s3_bucket_arn}",
      "${module.s3.s3_bucket_arn}/*",
    ]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = ["${module.cdn.cloudfront_distribution_arn}"]
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

data "aws_cloudfront_response_headers_policy" "this" {
  name = "Managed-SecurityHeadersPolicy"
}

data "aws_cloudfront_cache_policy" "this" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_origin_request_policy" "this" {
  name = "Managed-CORS-S3Origin"
}
