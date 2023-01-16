# Terraform Modules Template

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.50 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.50 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cdn"></a> [cdn](#module\_cdn) | terraform-aws-modules/cloudfront/aws | ~> 3.1.0 |
| <a name="module_s3"></a> [s3](#module\_s3) | terraform-aws-modules/s3-bucket/aws | ~> 3.5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_function.viewer_request](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_function) | resource |
| [aws_s3_bucket_policy.docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_iam_policy_document.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_policy_merge](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | Private or Public ACL | `string` | `"private"` | no |
| <a name="input_attach_policy"></a> [attach\_policy](#input\_attach\_policy) | Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy) | `bool` | `true` | no |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | bucket name | `string` | `""` | no |
| <a name="input_cors_rule"></a> [cors\_rule](#input\_cors\_rule) | List of maps containing rules for Cross-Origin Resource Sharing. | `any` | <pre>{<br>  "cors_rule": {<br>    "allowed_headers": [<br>      "*"<br>    ],<br>    "allowed_methods": [<br>      "PUT",<br>      "POST",<br>      "GET",<br>      "DELETE"<br>    ],<br>    "allowed_origins": [<br>      "*"<br>    ],<br>    "expose_headers": [<br>      "ETag"<br>    ],<br>    "max_age_seconds": 3000<br>  }<br>}</pre> | no |
| <a name="input_create_origin_access_identity"></a> [create\_origin\_access\_identity](#input\_create\_origin\_access\_identity) | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_default_cache_behavior"></a> [default\_cache\_behavior](#input\_default\_cache\_behavior) | The default cache behavior for this distribution | `any` | `{}` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_lifecycle_rule"></a> [lifecycle\_rule](#input\_lifecycle\_rule) | List of maps containing configuration of object lifecycle management. | `any` | `[]` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | Map containing access bucket logging configuration. | `map(string)` | `{}` | no |
| <a name="input_ordered_cache_behavior"></a> [ordered\_cache\_behavior](#input\_ordered\_cache\_behavior) | An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0. | `any` | `[]` | no |
| <a name="input_origin"></a> [origin](#input\_origin) | One or more origins for this distribution (multiples allowed). | `any` | `{}` | no |
| <a name="input_origin_access_identities"></a> [origin\_access\_identities](#input\_origin\_access\_identities) | Map of CloudFront origin access identities (value as a comment) | `map(string)` | `{}` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | A valid bucket policy JSON document (Optional) | `string` | `""` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | The price class for this distribution. One of PriceClass\_All, PriceClass\_200, PriceClass\_100 | `string` | `"PriceClass_All"` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_server_side_encryption_configuration"></a> [server\_side\_encryption\_configuration](#input\_server\_side\_encryption\_configuration) | Map containing server-side encryption configuration. | `any` | `{}` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Map containing versioning configuration. | `map(string)` | <pre>{<br>  "enabled": true<br>}</pre> | no |
| <a name="input_wait_for_deployment"></a> [wait\_for\_deployment](#input\_wait\_for\_deployment) | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | `false` | no |
| <a name="input_website"></a> [website](#input\_website) | Map containing static web-site hosting or redirect configuration. | `any` | <pre>{<br>  "error_document": "error.html",<br>  "index_document": "index.html"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_distribution_arn"></a> [cloudfront\_distribution\_arn](#output\_cloudfront\_distribution\_arn) | The ARN (Amazon Resource Name) for the distribution. |
| <a name="output_cloudfront_distribution_domain_name"></a> [cloudfront\_distribution\_domain\_name](#output\_cloudfront\_distribution\_domain\_name) | The domain name corresponding to the distribution. |
| <a name="output_cloudfront_distribution_id"></a> [cloudfront\_distribution\_id](#output\_cloudfront\_distribution\_id) | The Arn of the cloudfront distribution |
| <a name="output_cloudfront_origin_access_identity_iam_arns"></a> [cloudfront\_origin\_access\_identity\_iam\_arns](#output\_cloudfront\_origin\_access\_identity\_iam\_arns) | The IAM arns of the origin access identities created |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname. |
| <a name="output_s3_bucket_bucket_domain_name"></a> [s3\_bucket\_bucket\_domain\_name](#output\_s3\_bucket\_bucket\_domain\_name) | The bucket domain name. Will be of format bucketname.s3.amazonaws.com. |
| <a name="output_s3_bucket_bucket_regional_domain_name"></a> [s3\_bucket\_bucket\_regional\_domain\_name](#output\_s3\_bucket\_bucket\_regional\_domain\_name) | The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL. |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | The name of the bucket. |
<!-- END_TF_DOCS -->
