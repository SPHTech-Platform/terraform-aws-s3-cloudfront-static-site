resource "aws_route53_record" "domain" {
  for_each = var.domains

  zone_id = each.value.dns_zone_id
  name    = each.value.domain
  type    = "A"

  alias {
    name                   = module.cdn.cloudfront_distribution_domain_name
    zone_id                = module.cdn.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "acm" {
  for_each = { for k, domain in var.domains : k => domain if domain.include_in_acm && domain.create_acm_record }

  zone_id = each.value.dns_zone_id
  name    = module.acm.validation_domains[each.value.domain]["resource_record_name"]
  type    = module.acm.validation_domains[each.value.domain]["resource_record_type"]
  records = module.acm.validation_domains[each.value.domain]["resource_record_value"]
  ttl     = 300

  allow_overwrite = true
}
