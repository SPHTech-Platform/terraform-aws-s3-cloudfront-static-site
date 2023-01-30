variable "bucket_name" {
  description = "bucket name"
  type        = string
  default     = ""
}

variable "acl" {
  description = "Private or Public ACL"
  type        = string
  default     = "private"
}

variable "attach_policy" {
  description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
  type        = bool
  default     = true
}

variable "policy" {
  description = "A valid bucket policy JSON document (Optional)"
  type        = string
  default     = ""
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "server_side_encryption_configuration" {
  description = "Map containing server-side encryption configuration."
  type        = any
  default     = {}
}

variable "lifecycle_rule" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  default     = []
}

variable "cors_rule" {
  description = "List of maps containing rules for Cross-Origin Resource Sharing for S3 bucket."
  type        = any
  default = {
    cors_rule = {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST", "GET", "DELETE"]
      allowed_origins = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  }
}

variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default = {
    enabled = true
  }
}

variable "logging" {
  description = "Map containing access bucket logging configuration."
  type        = map(string)
  default     = {}
}

variable "website" {
  description = "Map containing static web-site hosting or redirect configuration."
  type        = any # map(string)
  default = {
    index_document = "index.html"
    error_document = "error.html"
  }
}

variable "wait_for_deployment" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = false
}

variable "create_origin_access_identity" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "ordered_cache_behavior" {
  description = "An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0."
  type        = any
  default     = []
}

variable "price_class" {
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  type        = string
  default     = "PriceClass_All"
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

variable "default_cache_behavior" {
  description = "The default cache behavior for this distribution"
  type        = any
  default     = {}
}

variable "default_root_object" {
  description = "Default root object"
  type        = string
  default     = "index.html"
}

variable "custom_error_response" {
  description = "Custom error response settings, if any"
  type        = list(any)
  default     = []
}

variable "geo_restriction" {
  description = "Geo-restriction settings, if any"
  type        = any
  default     = {}
}

variable "certificate_settings" {
  description = "CloudFront certificate settings"
  type        = any
  default = {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

variable "domains" {
  description = "Domains to update DNS records for amd create ACM certificates"
  type = map(object({ # Key is arbitrary and not used
    dns_zone_id = string
    domain      = string

    include_in_acm    = optional(bool, false)
    create_acm_record = optional(bool, true)
  }))
  default = {}
}

variable "acm_key_algorithm" {
  description = "ACM certificate algorithm"
  type        = string
  default     = "EC_prime256v1"
}
