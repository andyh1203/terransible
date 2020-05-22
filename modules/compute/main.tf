# ----- Dev Instance -----
resource "aws_instance" "wp_dev" {
  instance_type = var.dev_instance_type
  ami           = var.dev_ami

  tags = var.wp_dev_tags

  key_name = var.key_name
  vpc_security_group_ids = var.vpc_dev_ec2_security_group_ids
  iam_instance_profile = var.iam_instance_profile
  subnet_id            = var.public_subnet_id

  provisioner "local-exec" {
    command = <<EOD
    cat <<EOF > aws_hosts
    [dev]
    ${aws_instance.wp_dev.public_ip}
    [dev:vars]
    s3code=${var.s3_code_bucket}
    domain=${var.domain_name}
    EOD
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.wp_dev.id} && ansible-playbook -i aws_hosts wordpress.yml"
  }
}

# ----- Load balance -----
resource "aws_elb" "wp_elb" {
  name = "${var.domain_name}-elb"
  subnets = var.vpc_public_subnets
  security_groups = var.elb_security_groups
  listener {
    instance_port     = var.elb_listener_instance_port
    instance_protocol = var.elb_listener_instance_protocol
    lb_port           = var.elb_lb_port
    lb_protocol       = var.elb_lb_protocol
  }

  health_check {
    healthy_threshold   = var.elb_healthy_threshold
    unhealthy_threshold = var.elb_unhealthy_threshold
    timeout             = var.elb_timeout
    target              = var.elb_health_check_target
    interval            = var.elb_interval
  }
  cross_zone_load_balancing   = var.elb_cross_zone_load_balancing
  idle_timeout                = var.elb_idle_timeout
  connection_draining         = var.elb_connection_draining
  connection_draining_timeout = var.elb_connection_draining_timeout

  tags = var.elb_tags
}

# ----- Golden AMI -----

# random ami id
resource "random_id" "golden_ami" {
  byte_length = 3
}

resource "aws_ami_from_instance" "wp_golden" {
  name               = "wp_ami-${random_id.golden_ami.b64}"
  source_instance_id = aws_instance.wp_dev.id
  provisioner "local-exec" {
    command = <<EOT
cat <<EOF > userdata
#!/bin/bash
/usr/bin/aws s3 sync s3://${var.s3_code_bucket} /var/www/html
/bin/touch /var/spool/cron/root
sudo bin/echo '*/5 * * * * aws s3 sync s3://${var.s3_code_bucket} /var/www/html' >> /var/spool/cron/root
EOF
EOT
  }
}

# ----- Launch Configuration -----
resource "aws_launch_configuration" "wp_lc" {
  name_prefix   = var.lc_name_prefix
  image_id      = aws_ami_from_instance.wp_golden.id
  instance_type = var.lc_instance_type
  security_groups = var.vpc_private_sg_ids
  iam_instance_profile = var.iam_instance_profile
  key_name             = var.key_name
  user_data            = file("userdata")

  lifecycle {
    create_before_destroy = true
  }
}

# ---- ASG -----
resource "aws_autoscaling_group" "wp_asg" {
  name                      = "asg-${aws_launch_configuration.wp_lc.id}"
  max_size                  = var.asg_max
  min_size                  = var.asg_min
  health_check_grace_period = var.asg_grace
  health_check_type         = var.asg_hct
  desired_capacity          = var.asg_cap
  force_delete              = var.asg_force_delete
  load_balancers = [
    aws_elb.wp_elb.id
  ]
  vpc_zone_identifier = var.vpc_private_subnet_ids
  launch_configuration = aws_launch_configuration.wp_lc.name

  tag {
    key                 = "Name"
    value               = var.asg_name_tag_value
    propagate_at_launch = var.asg_name_tag_propagate_at_launch
  }

  lifecycle {
    create_before_destroy = true
  }
}
