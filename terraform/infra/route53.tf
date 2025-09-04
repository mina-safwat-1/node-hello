
variable "subdomains" {
    description = "The subdomain to create the record for"
    type        = list(string)
    default     = [
    "argocd.itiproject.site",
    "www.itiproject.site"
  ]
  
}


variable "domain_name" {
    description = "The domain name to create the record for"
    type        = string
    default     = "itiproject.site"
  
}



data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
  
}



resource "aws_acm_certificate" "itiproject_cert" {
  domain_name               = "itiproject.site"
  validation_method         = "DNS"
  subject_alternative_names = var.subdomains

  tags = {
    Name = "itiproject-multi-cert"
  }
}


resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.itiproject_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 300
}