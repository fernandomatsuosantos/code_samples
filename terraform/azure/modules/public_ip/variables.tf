variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the public ip"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists"
}

variable "name" {
  description = "Name for the Public IP"
}

variable "domain_name_label" {
  description = "Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system"
}

variable "allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic"
  default     = "Static"
}

variable "ip_version" {
  description = "The IP Version to use, IPv6 or IPv4"
}

variable "sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic"
}
