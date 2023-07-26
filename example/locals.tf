locals {
  acm_domains = [for domain in var.domains : domain if domain.include_in_acm]
}
