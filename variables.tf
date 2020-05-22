variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "aws_profile" {
  description = "Profile to access AWS with"
  type        = string
  default     = "default"
}

variable "s3_access_role_name" {
  description = "Name of the role to access S3"
  type        = string
  default     = "s3_access_role"
}

variable "s3_access_profile_name" {
  description = "Name of the instance profile used to access S3"
  type        = string
  default     = "s3_access_profile_name"
}

variable "s3_access_policy_name" {
  description = "Name of the policy for accessing S3"
  type        = string
  default     = "s3_access_policy"
}

variable domain_name {
  description = "Your domain name"
  type        = string
}

variable "acl" {
  description = "Canned ACL to apply. Defaults to 'private'."
  type        = string
  default     = "private"
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "byte_length" {
  description = "Byte length for random_id to add as suffix of bucket name"
  type        = number
  default     = 2
}

variable "s3_bucket_tags" {
  description = "A mapping of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}

data "aws_availability_zones" "available" {
  state = "available"
}
variable vpc_cidr {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}
variable "cidrs" {
  description = "VPC Subnet CIDRs"
  type        = map(string)
  default = {
    public1  = "10.0.1.0/24"
    public2  = "10.0.2.0/24"
    private1 = "10.0.3.0/24"
    private2 = "10.0.4.0/24"
    rds1     = "10.0.5.0/24"
    rds2     = "10.0.6.0/24"
    rds3     = "10.0.7.0/24"
  }
}
variable "localip" {
  description = "You local IP"
  type        = string
}

variable "db_username" {
  description = "RDS Username"
  type        = string
}
variable "db_password" {
  description = "RDS Password"
  type        = string
}
variable "db_name" {
  description = "RDS schema / DB"
  type        = string
}
variable "db_instance_class" {
  description = "EC2 instance class"
  type        = string
  default     = "db.t2.micro"
}
variable "dev_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
variable "dev_ami" {
  description = "AMI for dev instance"
  type        = string
  default     = "ami-0d6621c01e8c2de2c" # AMZNLINUX2
}
variable "public_key_path" {
  description = "Public key path"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
variable "key_name" {
  description = "Name of the key to create"
  type        = string
}
variable "elb_healthy_threshold" {
  description = "Elastic load balance healthy threshold"
  type        = string
  default     = "2"
}
variable "elb_unhealthy_threshold" {
  description = "Elastic load balance unhealthy threshold"
  type        = string
  default     = "2"
}
variable "elb_timeout" {
  description = "Elastic load balance timeout"
  type        = string
  default     = "3"
}
variable "elb_interval" {
  description = "Elastic load balance interval"
  type        = string
  default     = "30"
}
variable "lc_instance_type" {
  description = "Launch configuration instance type"
  type        = string
  default     = "t2.micro"
}
variable "asg_max" {
  description = "Auto Scaling Group max number of instances"
  type        = string
  default     = "2"
}
variable "asg_min" {
  description = "Auto Scaling Group min number of instances"
  type        = string
  default     = "1"
}
variable "asg_grace" {
  description = "Auto Scaling Group cooldown period"
  type        = string
  default     = "300"
}
variable "asg_hct" {
  description = "Auto Scaling Group health check type"
  type        = string
  default     = "EC2"
}
variable "asg_cap" {
  description = "Auto Scaling Group capacity"
  type        = string
  default     = "2"
}
variable "delegation_set" {
  description = "Route53 delegation set"
  type        = string
}
variable "db_allocated_storage" {
  description = "Allocated storage to EBS volume"
  type        = number
  default     = 10
}
variable "db_storage_type" {
  description = "EBS volume storage type"
  type        = string
  default     = "gp2"
}
variable "db_engine" {
  description = "DB engine type"
  type        = string
  default     = "mysql"
}
variable "db_engine_version" {
  description = "DB engine version"
  type        = string
  default     = "5.7"
}
variable "db_skip_final_snapshot" {
  description = "Whether or not to skip final snapshot when destroying DB"
  type        = bool
  default     = true
}
variable "wp_dev_tags" {
  description = "Dev instance tags"
  type        = map(string)
}
variable "elb_cross_zone_load_balancing" {
  description = "Whether or not to enable cross zone load balancing"
  type        = bool
  default     = true
}
variable "elb_idle_timeout" {
  description = "Elastic load balance idle timeout in seconds"
  type        = number
  default     = 400
}
variable "elb_connection_draining" {
  description = "Whether or not to enable connection draining on the ELB"
  type        = bool
  default     = true
}
variable "elb_connection_draining_timeout" {
  description = "Connection draining timeout"
  type        = number
  default     = 400
}
variable "elb_tags" {
  description = "ELB tags"
  type        = map(string)
}
variable "elb_health_check_target" {
  description = "ELB health check target"
  type        = string
  default     = "TCP:80"
}
variable "elb_listener_instance_port" {
  description = "Elastic load balance instance port"
  type        = number
  default     = 80
}
variable "elb_listener_instance_protocol" {
  description = "Elastic load balance instance protocol"
  type        = string
  default     = "http"
}
variable "elb_lb_port" {
  description = "Load balance instance port"
  type        = number
  default     = 80
}
variable "elb_lb_protocol" {
  description = "Load balance instance protocol"
  type        = string
  default     = "http"
}
variable "lc_name_prefix" {
  description = "Launch configuration name prefix"
  type        = string
  default     = "wp_lc-"
}
variable "asg_force_delete" {
  description = "Whether or not to force delete auto scaling group"
  type        = bool
  default     = true
}
variable "asg_name_tag_value" {
  description = "Value for the Name tag"
  type        = string
  default     = "wp_asg-instance"
}
variable "asg_name_tag_propagate_at_launch" {
  description = "Whether to propagate name tag at launch"
  type        = bool
  default     = true
}
variable "www_alias_evaluate_target_health" {
  description = "Whether or not to evaluate target health"
  type        = bool
  default     = false
}
variable "dev_route_record_type" {
  description = "Record type for dev route"
  type        = string
  default     = "A"
}
variable "dev_route_ttl" {
  description = "TTL for dev route"
  type        = string
  default     = "300"
}
variable "db_route_record_type" {
  description = "Record type for db route"
  type        = string
  default     = "CNAME"
}
variable "db_route_ttl" {
  description = "TTL for db route"
  type        = string
  default     = "300"
}
variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}
variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}
variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  type        = map(string)
  default     = {}
}
variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  type        = map(string)
  default     = {}
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route tables"
  type        = map(string)
  default     = {}
}

variable "public1_subnet_tags" {
  description = "Additional tags for the first public subnet"
  type        = map(string)
  default     = {}
}

variable "public2_subnet_tags" {
  description = "Additional tags for the second public subnet"
  type        = map(string)
  default     = {}
}

variable "private1_subnet_tags" {
  description = "Additional tags for the first private subnet"
  type        = map(string)
  default     = {}
}

variable "private2_subnet_tags" {
  description = "Additional tags for the second private subnet"
  type        = map(string)
  default     = {}
}

variable "rds1_subnet_tags" {
  description = "Additional tags for the first rds subnet"
  type        = map(string)
  default     = {}
}

variable "rds2_subnet_tags" {
  description = "Additional tags for the second rds subnet"
  type        = map(string)
  default     = {}
}

variable "rds3_subnet_tags" {
  description = "Additional tags for the third rds subnet"
  type        = map(string)
  default     = {}
}

variable "rds_subnet_group_tags" {
  description = "Additional tags for the third rds subnet"
  type        = map(string)
  default     = {}
}







