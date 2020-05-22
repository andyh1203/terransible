#----- IAM -----
module "iam" {
  source                 = "./modules/iam"
  s3_access_role_name    = var.s3_access_role_name
  s3_access_profile_name = var.s3_access_profile_name
  s3_access_policy_name  = var.s3_access_policy_name
}

# ----- VPC -----
module "vpc" {
  source                   = "./modules/vpc"
  vpc_cidr                 = var.vpc_cidr
  localip                  = var.localip
  enable_dns_hostnames     = var.enable_dns_hostnames
  enable_dns_support       = var.enable_dns_support
  igw_tags                 = var.igw_tags
  public_route_table_tags  = var.public_route_table_tags
  private_route_table_tags = var.private_route_table_tags
  aws_region               = var.aws_region
  public1_subnet_tags      = var.public1_subnet_tags
  public2_subnet_tags      = var.public2_subnet_tags
  private1_subnet_tags     = var.private1_subnet_tags
  private2_subnet_tags     = var.private2_subnet_tags
  rds1_subnet_tags         = var.rds1_subnet_tags
  rds2_subnet_tags         = var.rds2_subnet_tags
  rds3_subnet_tags         = var.rds3_subnet_tags
  rds_subnet_group_tags    = var.rds_subnet_group_tags
}


# ----- S3 code bucket -----
module "s3" {
  source        = "./modules/s3"
  domain_name   = var.domain_name
  acl           = var.acl
  force_destroy = var.force_destroy
  byte_length   = var.byte_length

  tags = var.s3_bucket_tags
}

# ----- RDS -----
module "rds" {
  source = "./modules/rds"

  db_name                    = var.db_name
  db_allocated_storage       = var.db_allocated_storage
  db_storage_type            = var.db_storage_type
  db_engine                  = var.db_engine
  db_engine_version          = var.db_engine_version
  db_instance_class          = var.db_instance_class
  db_username                = var.db_username
  db_password                = var.db_password
  db_skip_final_snapshot     = var.db_skip_final_snapshot
  db_subnet_group_name       = module.vpc.db_subnet_group_name
  vpc_rds_security_group_ids = module.vpc.vpc_rds_security_group_ids
}

# # ----- Key Pair -----
module "key_pair" {
  source          = "./modules/key_pair"
  key_name        = var.key_name
  public_key_path = var.public_key_path
}

# # ----- Compute -----
module "compute" {
  source                           = "./modules/compute"
  dev_ami                          = var.dev_ami
  dev_instance_type                = var.dev_instance_type
  domain_name                      = var.domain_name
  elb_healthy_threshold            = var.elb_healthy_threshold
  elb_unhealthy_threshold          = var.elb_unhealthy_threshold
  elb_timeout                      = var.elb_timeout
  elb_interval                     = var.elb_interval
  lc_instance_type                 = var.lc_instance_type
  asg_max                          = var.asg_max
  asg_min                          = var.asg_min
  asg_grace                        = var.asg_grace
  asg_hct                          = var.asg_hct
  asg_cap                          = var.asg_cap
  wp_dev_tags                      = var.wp_dev_tags
  elb_cross_zone_load_balancing    = var.elb_cross_zone_load_balancing
  elb_idle_timeout                 = var.elb_idle_timeout
  elb_connection_draining          = var.elb_connection_draining
  elb_connection_draining_timeout  = var.elb_connection_draining_timeout
  elb_tags                         = var.elb_tags
  elb_health_check_target          = var.elb_health_check_target
  elb_listener_instance_port       = var.elb_listener_instance_port
  elb_listener_instance_protocol   = var.elb_listener_instance_protocol
  elb_lb_port                      = var.elb_lb_port
  elb_lb_protocol                  = var.elb_lb_protocol
  lc_name_prefix                   = var.lc_name_prefix
  asg_force_delete                 = var.asg_force_delete
  asg_name_tag_value               = var.asg_name_tag_value
  asg_name_tag_propagate_at_launch = var.asg_name_tag_propagate_at_launch
  key_name                         = module.key_pair.key_name
  vpc_dev_ec2_security_group_ids   = module.vpc.vpc_dev_ec2_security_group_ids
  iam_instance_profile             = module.iam.instance_profile_id
  public_subnet_id                 = module.vpc.public_subnet_1
  s3_code_bucket                   = module.s3.bucket
  elb_security_groups              = module.vpc.elb_security_groups
  vpc_public_subnets               = module.vpc.public_subnets
  vpc_private_sg_ids               = module.vpc.private_sg_ids
  vpc_private_subnet_ids           = module.vpc.private_subnet_ids
}

# # # ----- Route53 -----
module "route53" {
  source                           = "./modules/route53"
  delegation_set                   = var.delegation_set
  domain_name                      = var.domain_name
  www_alias_evaluate_target_health = var.www_alias_evaluate_target_health
  dev_route_record_type            = var.dev_route_record_type
  dev_route_ttl                    = var.dev_route_ttl
  db_route_record_type             = var.db_route_record_type
  db_route_ttl                     = var.db_route_ttl
  elb_dns_name                     = module.compute.elb_dns_name
  elb_zone_id                      = module.compute.elb_zone_id
  dev_instance_public_ips          = module.compute.dev_instance_public_ips
  db_addresses                     = module.rds.db_addresses
  vpc_id                           = module.vpc.vpc_id
}
