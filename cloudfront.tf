module "cdn" {
  #checkov:skip=CKV_TF_1:Ensure Terraform module sources use a commit hash
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "~> 3.2.1"

  aliases = [for domain in var.domains : domain.domain]

  comment             = "Distribution for static website"
  is_ipv6_enabled     = true
  price_class         = var.price_class
  wait_for_deployment = var.wait_for_deployment

  create_origin_access_identity = var.create_origin_access_identity
  origin_access_identities      = var.origin_access_identities

  create_origin_access_control = var.create_origin_access_control
  origin_access_control = merge({
    s3 = {
      description      = "Cloudfront origin access control",
      origin_type      = "s3",
      signing_behavior = "always",
      signing_protocol = "sigv4"
    }
  }, var.origin_access_control)

  origin = merge({
    origin_access_control = {
      domain_name           = module.s3.s3_bucket_bucket_regional_domain_name
      origin_path           = ""
      origin_access_control = "s3" # key in `origin_access_control`
      origin_shield = {
        enabled              = true
        origin_shield_region = "ap-southeast-1"
      }
    }
  }, var.origin)

  default_cache_behavior = merge({
    target_origin_id       = "origin_access_identity" # key in `origin` above
    viewer_protocol_policy = "redirect-to-https"

    default_ttl = 360
    min_ttl     = 300
    max_ttl     = 600

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = false

    use_forwarded_values = false

    response_headers_policy_id = data.aws_cloudfront_response_headers_policy.this.id
    origin_request_policy_id   = data.aws_cloudfront_origin_request_policy.this.id
    cache_policy_id            = data.aws_cloudfront_cache_policy.this.id

    function_association = {
      viewer-request = {
        function_arn = aws_cloudfront_function.viewer_request.arn
      }
    }
  }, var.default_cache_behavior)

  ordered_cache_behavior = var.ordered_cache_behavior
  default_root_object    = var.default_root_object
  custom_error_response  = var.custom_error_response
  geo_restriction        = var.geo_restriction

  viewer_certificate = length(local.acm_domains) > 0 ? merge(
    {
      acm_certificate_arn = module.acm.acm_certificate_arn
    },
    var.certificate_settings,
  ) : {}

  web_acl_id = var.web_acl_id
}

resource "aws_cloudfront_function" "viewer_request" {
  name    = var.default_index_function_name
  runtime = "cloudfront-js-1.0"
  publish = true
  code    = var.override_default_index_function_code == "" ? templatefile("${path.module}/templates/viewer-request-default.js", { default_root_object = var.default_root_object }) : var.override_default_index_function_code
}
