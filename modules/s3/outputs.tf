output "id" {
  description = "The instance profile's ID"
  value       = aws_s3_bucket.code.id
}

output "arn" {
  description = "The ARN assigned by AWS to the instance profile."
  value       = aws_s3_bucket.code.arn
}

output "bucket" {
  description = "The S3 code bucket"
  value       = aws_s3_bucket.code.bucket
}
