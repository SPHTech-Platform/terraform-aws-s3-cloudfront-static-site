locals {
  acm_domains = [for obj in var.domains : obj.domain if obj.include_in_acm]
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.3.0"

  providers = {
    aws = aws.us-east-1
  }

  create_certificate     = true
  create_route53_records = false
  wait_for_validation    = false

  key_algorithm = var.acm_key_algorithm

  domain_name               = local.acm_domains[0]
  subject_alternative_names = slice(local.acm_domains, 1, length(local.acm_domains))
}
