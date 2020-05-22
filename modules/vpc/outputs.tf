output "db_subnet_group_name" {
    description = "The AWS DB subnet group"
    value = aws_db_subnet_group.wp_rds_subnet_group.name
}

output "vpc_rds_security_group_ids" {
    description = "VPC security group IDs"
    value = [aws_security_group.wp_rds_sg.id]
}

output "elb_security_groups" {
    description = "SG for ELB"
    value = [
    aws_security_group.wp_public_sg.id
  ]
}

output "public_subnets" {
    description = "Public subnets"
    value = [
    aws_subnet.wp_public1_subnet.id,
    aws_subnet.wp_public2_subnet.id
  ]
}

output "vpc_dev_ec2_security_group_ids" {
  value = [
    aws_security_group.wp_dev_sg.id
  ]
}

output "public_subnet_1" {
  value = aws_subnet.wp_public1_subnet.id
}

output "private_sg_ids" {
  value = [
    aws_security_group.wp_private_sg.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.wp_private1_subnet.id,
    aws_subnet.wp_private2_subnet.id
  ]
}

output "vpc_id" {
  value = aws_vpc.wp_vpc.id
}