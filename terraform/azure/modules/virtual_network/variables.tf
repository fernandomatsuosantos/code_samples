variable "name" {
  description = "Name of the virtual network"
}

variable "resource_group_name" {
  description = "Name of the parent resource group"
}

variable "location" {
  description = "Location of the virtual network"
}

variable "address_space" {
  description = "Address Space of the network"
  type        = list(string)
}