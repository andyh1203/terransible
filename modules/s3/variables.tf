variable "domain_name" {
  description = "Your domain name"
  type        = string
}

variable "acl" {
    description = "Canned ACL to apply. Defaults to 'private'."
    type = string
    default = "private"
}

variable "tags" {
  description = "A mapping of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "byte_length" {
    description = "Byte length for random_id to add as suffix of bucket name"
    type = number
    default = 2
}
