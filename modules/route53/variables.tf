variable delegation_set {
  description = "Route53 delegation set"
  type        = string
}
variable domain_name {
  description = "Your domain name"
  type        = string
}
variable "elb_dns_name" {
    description = "Elastic load balance DNS name"
    type = string
}
variable "elb_zone_id" {
    description = "Elastic load balance Zone Id"
    type = string
}
variable "dev_instance_public_ips" {
    description = "Dev instance public Ips"
    type = list
}
variable "db_addresses" {
    description = "Database host addresses"
    type = list
}
variable "vpc_id" {
    description = "VPC Id"
    type = string
}
variable "www_alias_evaluate_target_health" {
    description = "Whether or not to evaluate target health"
    type = bool
    default = false
}
variable "dev_route_record_type" {
    description = "Record type for dev route"
    type = string
    default = "A"
}
variable "dev_route_ttl" {
    description = "TTL for dev route"
    type = string
    default = "300"
}
variable "db_route_record_type" {
    description = "Record type for db route"
    type = string
    default = "CNAME"
}
variable "db_route_ttl" {
    description = "TTL for db route"
    type = string
    default = "300"
}
