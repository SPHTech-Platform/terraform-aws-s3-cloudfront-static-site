##################
### Static S3
#################

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
  description = "(Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
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
  description = "List of maps containing rules for Cross-Origin Resource Sharing."
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

