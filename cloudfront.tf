module "cdn" {
  source                        = "terraform-aws-modules/cloudfront/aws"
  comment                       = "Distribution for static website"
  is_ipv6_enabled               = true
  price_class                   = var.price_class
  wait_for_deployment           = var.wait_for_deployment
  create_origin_access_identity = var.create_origin_access_identity

  origin_access_identities = merge({
    origin_access_identity = module.s3.s3_bucket_id
  }, var.origin_access_identities)

  origin = merge({
    origin_access_identity = {
      domain_name = module.s3.s3_bucket_bucket_regional_domain_name
      s3_origin_config = {
        origin_access_identity = "origin_access_identity"
        # key in `origin_access_identities`
    } }
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

    function_association = {
      viewer-request = {
        function_arn = aws_cloudfront_function.viewer_request.arn
      }
    }
  }, var.default_cache_behavior)

  ordered_cache_behavior = var.ordered_cache_behavior

  default_root_object = "index.html"

  custom_error_response = [
    {
      error_code         = 404
      response_code      = 404
      response_page_path = "/errors/404.html"
    },
    {
      error_code         = 403
      response_code      = 403
      response_page_path = "/errors/403.html"
    }
  ]
}

resource "aws_cloudfront_function" "viewer_request" {
  name    = "default_viewer_request"
  runtime = "cloudfront-js-1.0"
  publish = true
  code    = file("${path.module}/templates/viewer-request-default.js")
}
