variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "bucket" {
  description = "The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be less than or equal to 63 characters in length."
}

variable "acl" {
  description = "The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private. Conflicts with grant"
}

variable "versioning_enabled" {
  description = "A state of versioning"
}

variable "lifecycle_rule_enabled" {
  description = "Specifies lifecycle rule status."
}

variable "lifecycle_rule_expiration" {
  description = "Specifies a period in the object's expire"
}

variable "lifecycle_rule_noncurrent_version_expiration" {
  description = "Specifies when noncurrent object versions expire"
}