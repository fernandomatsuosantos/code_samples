variable "project_name" {
  description = "Name of the project"
}

variable "stage" {
  description = "Name of the stage"
}

variable "region" {
  description = "Name of the region"
}

variable "location" {
  description = "Location of the deployment"
}

variable "vnet_01_address_space" {
  description = "Virtual network address space for 01"
}

variable "waf_01_backend_address" {
  description = "One or more backend_address_pool blocks as defined below."
}

variable "waf_01_subnet_address_prefix" {
  description = "Subnet address prefix for the Application Gateway"
}

variable "aks_01_subnet_address_prefix" {
  description = "Subnet address prefix for the AKS"
}

variable "aks_01_max_pods" {
  description = "The maximum number of pods that can run on each agent. Changing this forces a new resource to be created"
}

variable "aks_01_vm_size" {
  description = "The size of the Virtual Machine, such as Standard_DS2_v2"
}

variable "aks_01_kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)."
}

variable "aks_01_orchestrator_version" {
  description = "Version of Kubernetes used for the Agents. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)"
}

variable "aks_01_load_balancer_sku" {
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are Basic and Standard. Defaults to Standard"
}

variable "aks_01_auto_scaling_min_count" {
  description = "The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
}

variable "aks_01_auto_scaling_max_count" {
  description = "The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
}

variable "aks_01_os_disk_size_gb" {
  description = "The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created."
}

variable "aks_01_availability_zones" {
  description = "A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
}