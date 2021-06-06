variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Location of the resource group"
}
