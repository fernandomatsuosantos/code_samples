variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "name" {
  description = "Friendly name of the role. If omitted, Terraform will assign a random, unique name. See IAM Identifiers for more information."
}

variable "assume_role_policy" {
  description = "Policy that grants an entity permission to assume the role."
}
