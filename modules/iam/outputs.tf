output "instance_profile_id" {
  description = "The instance profile's ID"
  value       = aws_iam_instance_profile.s3_access_profile.id
}

output "instance_profile_arn" {
  description = "The ARN assigned by AWS to the instance profile."
  value       = aws_iam_instance_profile.s3_access_profile.arn
}

output "instance_profile_name" {
  description = "The instance profile's name."
  value       = aws_iam_instance_profile.s3_access_profile.name
}

output "instance_profile_path" {
  description = "The path of the instance profile in IAM."
  value       = aws_iam_instance_profile.s3_access_profile.path
}

output "instance_profile_role" {
  description = "The role assigned to the instance profile."
  value       = aws_iam_instance_profile.s3_access_profile.role
}