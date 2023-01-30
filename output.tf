output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = module.s3.s3_bucket_id
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = module.s3.s3_bucket_arn
}

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = module.s3.s3_bucket_bucket_domain_name
}

output "s3_bucket_bucket_regional_domain_name" {
  description = "The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL."
  value       = module.s3.s3_bucket_bucket_regional_domain_name
}

output "cloudfront_distribution_id" {
  description = "The Arn of the cloudfront distribution"
  value       = module.cdn.cloudfront_distribution_id
}

output "cloudfront_distribution_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution."
  value       = module.cdn.cloudfront_distribution_arn
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = module.cdn.cloudfront_distribution_domain_name
}

output "cloudfront_origin_access_identity_iam_arns" {
  description = "The IAM arns of the origin access identities created"
  value       = module.cdn.cloudfront_origin_access_identity_iam_arns
}

output "cloudfront_distribution_hosted_zone_id" {
  description = "Route53 Zone ID for the Cloudfront Distribution"
  value       = module.cdn.cloudfront_distribution_hosted_zone_id
}
