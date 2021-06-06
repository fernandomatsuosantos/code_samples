variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "admin_account_id" {
  description = "AWS account identifier to designate as a delegated administrator for GuardDuty."
}
