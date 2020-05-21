output "elb_dns_name" {
    value = aws_elb.wp_elb.dns_name
}

output "elb_zone_id" {
    value = aws_elb.wp_elb.zone_id
}

output "dev_instance_public_ips" {
    value = [
    aws_instance.wp_dev.public_ip
  ]
}