locals {
  acm_domains  = [for domain in var.domains : domain if domain.include_in_acm]
  domain_parts = split(".", local.acm_domains[0].domain)
}

module "acm" {
  #checkov:skip=CKV_TF_1:Ensure Terraform module sources use a commit hash
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.3.0"

  providers = {
    aws = aws.us-east-1
  }

  create_certificate     = var.create_certificate
  create_route53_records = false
  wait_for_validation    = false

  key_algorithm = var.acm_key_algorithm

  domain_name               = local.acm_domains[0].domain
  subject_alternative_names = length(local.acm_domains) > 0 ? concat([format("*.%s", join(".", slice(local.domain_parts, 1, length(local.domain_parts))))]) : []
}
