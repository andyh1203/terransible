#----- IAM -----
module "iam" {
  source = "./modules/iam"

  s3_access_role_name    = var.s3_access_role_name
  s3_access_profile_name = var.s3_access_profile_name
  s3_access_policy_name  = var.s3_access_policy_name
}

# ----- VPC -----
module "vpc" {
  source = "./modules/vpc"

  localip = var.localip
}


# ----- S3 code bucket -----
module "s3" {
  source = "./modules/s3"

  domain_name   = var.domain_name
  acl           = var.acl
  force_destroy = var.force_destroy
  byte_length   = var.byte_length

  tags = var.s3_bucket_tags
}

# ----- RDS -----
module "rds" {
  source = "./modules/rds"

  db_subnet_group_name   = module.vpc.db_subnet_group_name
  vpc_security_group_ids = module.vpc.vpc_security_group_ids
  db_instance_class      = var.db_instance_class
  db_username            = var.db_username
  db_password            = var.db_password
  db_name                = var.db_name
}

# # ----- Key Pair -----
module "key_pair" {
  source   = "./modules/key_pair"
  key_name = var.key_name
  public_key_path = var.public_key_path
}

# # ----- Compute -----
module "compute" {
  source                  = "./modules/compute"
  dev_ami = var.dev_ami
  dev_instance_type = var.dev_instance_type
  domain_name             = var.domain_name
  elb_healthy_threshold   = var.elb_healthy_threshold
  elb_unhealthy_threshold = var.elb_unhealthy_threshold
  elb_timeout             = var.elb_timeout
  elb_interval            = var.elb_interval
  lc_instance_type        = var.lc_instance_type
  asg_max                 = var.asg_max
  asg_min                 = var.asg_min
  asg_grace               = var.asg_grace
  asg_hct                 = var.asg_hct
  asg_cap                 = var.asg_cap
  key_name                = module.key_pair.key_name
  vpc_security_group_ids  = module.vpc.vpc_dev_ec2_security_group_ids
  iam_instance_profile    = module.iam.instance_profile_id
  subnet_id               = module.vpc.public_subnet_1
  s3_code_bucket          = module.s3.bucket
  elb_sgs                 = module.vpc.elb_sgs
  public_subnets          = module.vpc.public_subnets
  vpc_private_sg_ids = module.vpc.private_sg_ids
  vpc_private_subnet_ids = module.vpc.private_subnet_ids
}

# # # ----- Route53 -----
module "route53" {
  source = "./modules/route53"
  delegation_set = var.delegation_set
  domain_name = var.domain_name
  elb_dns_name = module.compute.elb_dns_name
  elb_zone_id = module.compute.elb_zone_id
  dev_instance_public_ips = module.compute.dev_instance_public_ips
  db_addresses = module.rds.db_addresses
  vpc_id = module.vpc.vpc_id
}
