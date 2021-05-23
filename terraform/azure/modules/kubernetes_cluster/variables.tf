variable "name" {
  description = "Name of the AKS cluster"
}

variable "resource_group_name" {
  description = "Name of the parent resource group"
}

variable "location" {
  description = "Location of the AKS cluster"
}

variable "kubernetes_version" {
  description = "Kubernetes version of the AKS"
}

variable "max_pods" {
  description = "The maximum number of pods that can run on each agent"
}

variable "agent_pool_name" {
  description = "Name of the agent pool to use for aks"
  default     = "default"
}

variable "vm_size" {
  description = "VM Size of cluster nodes"

  #minimum Microsoft recommendation for running AKS
  default = "Standard_D4s_v3"
}

variable "vnet_name" {
  description = "Name of the vnet the AKS cluster will be placed in"
}

variable "vnet_address_space" {
  description = "Network address of the vnet the AKS cluster will be placed in (CIDR notation)"
  type        = list(string)
}

variable "service_endpoints" {
  type        = list(string)
  description = "List of service endpoints to be added to the AKS subnet"
}

variable "service_cidr" {
  default     = "172.16.0.0/16"
  description = "The Network Range used by the Kubernetes service."
}

variable "dns_service_ip" {
  default     = "172.16.0.10"
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns)."
}

variable "load_balancer_sku" {
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are Basic and Standard."
}

variable "enable_auto_scaling" {
  default     = "true"
  description = "Should the Kubernetes Auto Scaler be enabled for this Node Pool?"
}

variable "max_count" {
  description = "The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100"
}

variable "min_count" {
  description = "The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100"
}

variable "subnet_name" {
  description = "The name of the subnet. Changing this forces a new resource to be created."
}

variable "os_disk_size_gb" {
  description = "AKS disk size"
}

variable "orchestrator_version" {
  description = "Version of Kubernetes used for the Agents. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)"
}

variable "aks_name" {
  description = "Name of the AKS cluster"
}

variable "availability_zones" {
  description = "A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
}