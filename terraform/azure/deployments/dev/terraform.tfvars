################################################################################
# Common variables
################################################################################
project_name = "poc"
stage        = "dev"
region       = "us"
location     = "eastus"

################################################################################
# Variables for platform
################################################################################
vnet_01_address_space        = "10.1.0.0/16"   #65534 hosts - 10.1.0.1 to 10.1.255.254
waf_01_subnet_address_prefix = "10.1.255.0/28" #14 hosts - 10.1.255.1 to 10.1.255.14
waf_01_backend_address       = "10.1.127.254"

################################################################################
# Variables for AKS
################################################################################
aks_01_subnet_address_prefix  = "10.1.0.0/17" #32766 hosts
aks_01_max_pods               = "50"
aks_01_vm_size                = "Standard_B2s"
aks_01_kubernetes_version     = "1.19.9"
aks_01_orchestrator_version   = "1.19.9"
aks_01_load_balancer_sku      = "Standard"
aks_01_auto_scaling_min_count = 1
aks_01_auto_scaling_max_count = 3
aks_01_os_disk_size_gb        = 32
aks_01_availability_zones     = ["1", "2", "3"]