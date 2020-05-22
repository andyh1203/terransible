variable "elb_security_groups" {
    description = "Elastic load balancer security groups"
    type = list
}
variable "vpc_public_subnets" {
    description = "VPC public subnets"
    type = list
}
variable "domain_name" {
      description = "Your domain name"
  type        = string
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
variable "key_name" {
      description = "Name of the key to create"
  type        = string
}
variable "vpc_dev_ec2_security_group_ids" {
    description = "VPC dev server security group IDs"
    type = list
}
variable "iam_instance_profile" {
    description = "EC2 instance profile"
    type = string
}
variable "public_subnet_id" {
        description = "Public subnet ID"
    type = string
}
variable "s3_code_bucket" {
        description = "S3 bucket name"
    type = string
}
variable "vpc_private_sg_ids" {
    description = "VPC private security group IDs"
    type = list
}
variable "vpc_private_subnet_ids" {
        description = "VPC private subnet IDs"
    type = list
}
variable "wp_dev_tags" {
    description = "Dev instance tags" 
    type = map(string)
}
variable "elb_cross_zone_load_balancing" {
    description = "Whether or not to enable cross zone load balancing"
    type = bool
    default = true
}
variable "elb_idle_timeout" {
    description = "Elastic load balance idle timeout in seconds" 
    type = number
    default = 400
}
variable "elb_connection_draining" {
    description = "Whether or not to enable connection draining on the ELB"
    type = bool
    default = true
}
variable "elb_connection_draining_timeout" {
    description = "Connection draining timeout"
    type = number
    default = 400
}
variable "elb_health_check_target" {
    description = "ELB health check target"
    type = string
    default = "TCP:80"
}
variable "elb_tags" {
        description = "ELB tags" 
    type = map(string)
}
variable "elb_listener_instance_port" {
    description = "Elastic load balance instance port"
    type = number
    default = 80
}
variable "elb_listener_instance_protocol" {
    description = "Elastic load balance instance protocol"
    type = string
    default = "http"
}
variable "elb_lb_port" {
    description = "Load balance instance port"
    type = number
    default = 80
}
variable "elb_lb_protocol" {
    description = "Load balance instance protocol"
    type = string
    default = "http"
}
variable "lc_name_prefix" {
    description = "Launch configuration name prefix"
    type = string
    default = "wp_lc-"
}
variable "asg_force_delete" {
    description = "Whether or not to force delete auto scaling group"
    type = bool
    default = true
}
variable "asg_name_tag_value" {
    description = "Value for the Name tag"
    type = string
    default = "wp_asg-instance"
}
variable "asg_name_tag_propagate_at_launch" {
    description = "Whether to propagate name tag at launch"
    type = bool
    default = true
}