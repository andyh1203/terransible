
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
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

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
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

variable "database_route_table_tags" {
  description = "Additional tags for the database route tables"
  type        = map(string)
  default     = {}
}

variable cidrs {
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

variable aws_region {
  description = "AWS region"
  type = string
  default = "us-west-2"
}

variable "localip" {
  description = "Local IP"
  type = string
}

data "aws_availability_zones" "available" {
  state = "available"
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



