resource "aws_route53_record" "domain" {
  for_each = { for k, domain in var.domains : k => domain if domain.create_alias_record }

  zone_id = each.value.dns_zone_id
  name    = each.value.domain
  type    = "A"

  alias {
    name                   = module.cdn.cloudfront_distribution_domain_name
    zone_id                = module.cdn.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = true
  }
}

locals {
  domain_validation_records = {
    for dvo in module.acm.acm_certificate_domain_validation_options : dvo.domain_name => {
      resource_record_name  = dvo.resource_record_name
      resource_record_value = dvo.resource_record_value
      resource_record_type  = dvo.resource_record_type
    }
  }
}

resource "aws_route53_record" "acm" {
  for_each = { for k, domain in var.domains : k => domain if domain.include_in_acm && domain.create_acm_record }

  zone_id = each.value.dns_zone_id
  name    = local.domain_validation_records[each.value.domain]["resource_record_name"]
  type    = local.domain_validation_records[each.value.domain]["resource_record_type"]
  records = [local.domain_validation_records[each.value.domain]["resource_record_value"]]
  ttl     = 300

  allow_overwrite = true
}
