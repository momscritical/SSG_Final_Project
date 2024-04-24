variable "key_name" {
  description = "Key Pair Name Values"
  type        = string
  default     = ""
  sensitive = true
}

variable "public_key_location" {
  description = "Location of the Public key"
  type        = string
  default     = ""
  sensitive = true
}

variable "key_tags" {
  description = "Key Pair Tags Values"
  type        = string
  default     = ""
  sensitive = true
}