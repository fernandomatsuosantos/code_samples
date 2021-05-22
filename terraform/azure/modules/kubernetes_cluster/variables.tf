variable "name" {
  description = "Name of the AKS cluster"
}

variable "resource_group_name" {
  description = "Name of the parent resource group"
}

variable "location" {
  description = "Location of the AKS cluster"
}

variable "vm_size" {
  description = "VM Size of cluster nodes"

  #minimum Microsoft recommendation for running AKS
  default = "Standard_D4s_v3"
}

variable "agent_pool_name" {
  description = "The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created."
  default     = "default"
}

variable "node_count" {
  description = "The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100 and between min_count and max_count"
  default     = 1
}
