# Primary Zone
resource "aws_route53_zone" "primary" {
  name              = "${var.domain_name}.com"
  delegation_set_id = var.delegation_set
}

# WWW
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.${var.domain_name}.com"
  type    = "A"

  alias {
    name                   = var.elb_dns_name
    zone_id                = var.elb_zone_id
    evaluate_target_health = var.www_alias_evaluate_target_health
  }
}

# DEV
resource "aws_route53_record" "dev" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "dev.${var.domain_name}.com"
  type    = var.dev_route_record_type
  ttl     = var.dev_route_ttl
  records = var.dev_instance_public_ips
}

# Private zone
resource "aws_route53_zone" "secondary" {
  name = "${var.domain_name}.com"
  vpc {
    vpc_id = var.vpc_id
  }
}

#DB

resource "aws_route53_record" "db" {
  zone_id = aws_route53_zone.secondary.zone_id
  name    = "db.${var.domain_name}.com"
  type    = var.db_route_record_type
  ttl     = var.db_route_ttl
  records = var.db_addresses
}

