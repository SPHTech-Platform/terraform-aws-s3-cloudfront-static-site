#################
# Cloudfront Variables
#################
variable "create_origin_access_identity" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = false
}

variable "origin_access_identities" {
  description = "Map of CloudFront origin access identities (value as a comment)"
  type        = map(string)
  default     = {}
}

variable "origin" {
  description = "One or more origins for this distribution (multiples allowed)."
  type        = any
  default     = {}
}

variable "origin_path" {
  description = "Origin path to a specific directory in s3"
  type        = string
  default     = ""
}

variable "create_origin_access_control" {
  description = "Controls if CloudFront origin access control should be created"
  type        = bool
  default     = true
}

variable "origin_access_control" {
  description = "Map of CloudFront origin access control"
  type = map(object({
    description      = string
    origin_type      = string
    signing_behavior = string
    signing_protocol = string
  }))

  default = {}
}

variable "custom_error_response" {
  description = "Custom error response settings, if any"
  type        = list(any)
  default = [
    {
      error_code         = 404
      response_code      = 404
      response_page_path = "/errors/404.html"
    },
    {
      error_code         = 403
      response_code      = 403
      response_page_path = "/errors/403.html"
    },
  ]
}

variable "ordered_cache_behavior" {
  description = "An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0."
  type        = any
  default     = []
}

variable "default_root_object" {
  description = "Default root object"
  type        = string
  default     = "index.html"
}

variable "geo_restriction" {
  description = "Geo-restriction settings, if any"
  type        = any
  default     = {}
}

variable "domains" {
  description = "Domains or FQDNs to update DNS records and create ACM certificates"
  type = map(object({ # Key is arbitrary and not used
    dns_zone_id         = optional(string)
    domain              = string
    create_alias_record = optional(bool, true)
    include_in_acm      = optional(bool, false)
    create_acm_record   = optional(bool, true)
  }))
  default = {}
}

variable "domain_name" {
  description = "A domain name for which the certificate should be issued"
  type        = string
  default     = "www.example.com.sg"
}

variable "dns_zone_id" {
  description = "DNS zone ID for the domain"
  type        = string
  default     = ""
}

variable "subject_alternative_names" {
  description = "A list of domains that should be SANs in the issued certificate"
  type        = list(string)
  default     = []
}

variable "acm_key_algorithm" {
  description = "ACM certificate algorithm"
  type        = string
  default     = "EC_prime256v1"
}

variable "web_acl_id" {
  description = "A unique identifier that specifies the AWS WAF web ACL, if any, to associate with this distribution. To specify a web ACL created using the latest version of AWS WAF (WAFv2), use the ACL ARN, for example aws_wafv2_web_acl.example.arn. To specify a web ACL created using AWS WAF Classic, use the ACL ID, for example aws_waf_web_acl.example.id. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned."
  type        = string
  default     = ""
}

variable "certificate_settings" {
  description = "CloudFront certificate settings"
  type        = any
  default = {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

variable "default_cache_behavior" {
  description = "The default cache behavior for this distribution"
  type        = any
  default     = {}
}
