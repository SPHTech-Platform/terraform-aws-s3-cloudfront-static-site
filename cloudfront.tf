module "cdn" {
  #checkov:skip=CKV_TF_1:Ensure Terraform module sources use a commit hash
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "~> 6.8.0"

  create = var.create_distribution

  aliases = concat([for domain in var.domains : var.prefix != "" ? "${var.prefix}${domain.domain}" : domain.domain], var.additional_aliases)

  comment             = "Distribution for static website"
  is_ipv6_enabled     = true
  price_class         = var.price_class
  wait_for_deployment = var.wait_for_deployment
  http_version        = var.http_version

  origin_access_control = var.create_origin_access_control ? var.origin_access_control : {}

  logging_config = length(var.cloudfront_logging_config) > 0 ? var.cloudfront_logging_config : null

  origin = merge({
    origin_access_control = {
      domain_name               = module.s3.s3_bucket_bucket_regional_domain_name
      origin_path               = ""
      origin_access_control_key = var.s3_origin_access_control_key # key in `origin_access_control`
      origin_shield = {
        enabled              = true
        origin_shield_region = data.aws_region.current.region
      }
    }
  }, var.origin)

  default_cache_behavior = merge({
    target_origin_id       = "origin_access_control" # key in `OAC` above
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true

    response_headers_policy_id = data.aws_cloudfront_response_headers_policy.this.id
    origin_request_policy_id   = data.aws_cloudfront_origin_request_policy.this.id
    cache_policy_id            = data.aws_cloudfront_cache_policy.this.id

    function_association = var.create_associate_function ? {
      viewer-request = {
        function_arn = aws_cloudfront_function.viewer_request[0].arn
      }
    } : {}

  }, var.default_cache_behavior)

  ordered_cache_behavior = var.ordered_cache_behavior
  default_root_object    = var.default_root_object
  custom_error_response  = var.custom_error_response

  restrictions = {
    geo_restriction = merge({ restriction_type = "none" }, var.geo_restriction)
  }

  viewer_certificate = length(local.acm_domains) > 0 ? merge(
    {
      acm_certificate_arn = coalesce(
        module.acm.acm_certificate_arn,
        var.existing_acm_certificate_arn
      )
    },
    var.certificate_settings,
  ) : { minimum_protocol_version = "TLSv1" } # Default CloudFront certificate only supports TLSv1

  tags = var.tags

  web_acl_id = var.web_acl_id
}

resource "aws_cloudfront_function" "viewer_request" {
  count   = var.create_associate_function ? 1 : 0
  name    = var.default_index_function_name
  runtime = "cloudfront-js-1.0"
  publish = true
  code    = var.override_default_index_function_code == "" ? templatefile("${path.module}/templates/viewer-request-default.js", { default_root_object = var.default_root_object }) : var.override_default_index_function_code
}
