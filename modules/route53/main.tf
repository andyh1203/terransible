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
    evaluate_target_health = false
  }
}

# DEV
resource "aws_route53_record" "dev" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "dev.${var.domain_name}.com"
  type    = "A"
  ttl     = "300"
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
  type    = "CNAME"
  ttl     = "300"
  records = var.db_addresses
}

