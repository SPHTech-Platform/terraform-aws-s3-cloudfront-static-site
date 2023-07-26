#########
## Test for the static site terraform module
#########
module "s3_test_static" {
  source = "../../"
  providers = {
    aws.us-east-1 = aws.us-east-1
  }

  bucket_name = "static-site-testing-tfmodule"
  policy      = data.aws_iam_policy_document.s3_policy_additional.json

  domains = {
    default_domain = {
      dns_zone_id         = ""
      domain              = "example.com.sg"
      include_in_acm      = true
      create_acm_record   = false
      create_alias_record = false
    }
  }

  ordered_cache_behavior = [
    {
      path_pattern           = "/about-us"
      target_origin_id       = "origin_access_identity"
      viewer_protocol_policy = "https-only"

      allowed_methods = ["GET", "HEAD"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = false

      #Policy ID for CORS allow all origins with preflight and security headers
      response_headers_policy_id = "eaab4381-ed33-4a86-88ca-d9558dc6cd63"
    },
  ]
}

