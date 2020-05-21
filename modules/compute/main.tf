# ----- Dev Instance -----
resource "aws_instance" "wp_dev" {
  instance_type = var.dev_instance_type
  ami           = var.dev_ami

  tags = {
    Name = "wp_dev"
  }

  key_name = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile = var.iam_instance_profile
  subnet_id            = var.subnet_id

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
  subnets = var.public_subnets
  security_groups = var.elb_sgs
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = var.elb_healthy_threshold
    unhealthy_threshold = var.elb_unhealthy_threshold
    timeout             = var.elb_timeout
    target              = "TCP:80"
    interval            = var.elb_interval
  }
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "wp_${var.domain_name}-elb"
  }
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
  name_prefix   = "wp_lc-"
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
  force_delete              = true
  load_balancers = [
    aws_elb.wp_elb.id
  ]
  vpc_zone_identifier = var.vpc_private_subnet_ids
  launch_configuration = aws_launch_configuration.wp_lc.name

  tag {
    key                 = "Name"
    value               = "wp_asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
