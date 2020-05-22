variable public_key_path {
  description = "Public key path"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
variable key_name {
  description = "Name of the key to create"
  type        = string
}