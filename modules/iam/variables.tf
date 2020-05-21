variable "s3_access_role_name" {
  description = "The name of the role used for S3 access"
  type        = string
  default     = "s3_access_role"
}

variable "s3_access_profile_name" {
  description = "The name of the S3 access profile"
  type        = string
  default     = "s3_access"
}

variable "s3_access_policy_name" {
  description = "The name of the S3 access policy"
  type        = string
  default     = "s3_access_policy"
}