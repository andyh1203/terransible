resource "random_id" "wp_code_bucket" {
  byte_length = var.byte_length
}

resource "aws_s3_bucket" "code" {
  bucket        = "${var.domain_name}-${random_id.wp_code_bucket.dec}"
  acl           = var.acl
  force_destroy = var.force_destroy
  tags = var.tags
}
