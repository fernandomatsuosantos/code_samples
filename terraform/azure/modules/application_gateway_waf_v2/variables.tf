variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "name" {
  description = "Name of the WAF"
}

variable "resource_group_name" {
  description = "Name of the parent resource group"
}

variable "location" {
  description = "Location of the WAF"
}

variable "subnet_name" {
  description = "The name of the subnet. Changing this forces a new resource to be created"
}

variable "pip_name" {
  description = "Name for the Public IP of the WAF"
}

variable "pip_domain_name_label" {
  description = "Domain name label of the WAF"
}

variable "pip_ip_version" {
  description = "IP version of the Public IP"
}

variable "pip_sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic"
}


variable "vnet_id" {
  description = "Name of the vnet the waf will be placed in"
}

variable "vnet_name" {
  description = "Name of the vnet the waf will be placed in"
}

variable "vnet_address_space" {
  description = "Network address of the vnet in CIDR notation"
  type        = list(string)
}

variable "backend_port" {
  description = "The port the WAF will user for traffic forwarding"
}

variable "sku_name" {
  description = "The Name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2"
  default     = "WAF_v2"
}

variable "sku_tier" {
  description = "The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2"
  default     = "WAF_v2"
}

variable "capacity" {
  description = "Number of WAF nodes"
  default     = 1
}

variable "backend_address_pool" {
  description = "List of backend IP addresses the WAF will use for traffic forwarding"
  type        = list(string)
}

variable "backend_request_timeout" {
  description = "The request timeout in seconds, which must be between 1 and 86400 seconds"
}

variable "health_probe_name" {
  description = "The Name of the Probe."
  default     = "probe"
}

variable "health_probe_path" {
  description = "The Path used for this Probe"
  default     = "/"
}

variable "health_probe_protocol" {
  description = "The Protocol used for this Probe. Possible values are Http and Https"
  default     = "Http"
}

variable "pick_host_name_from_backend_http_settings" {
  description = "Whether the host header should be picked from the backend http settings. Defaults to false."
  default     = true
}
