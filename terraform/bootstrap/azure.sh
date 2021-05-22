#!/bin/bash

######################################################################
# Script Name    : azure.sh
# Description    : Terraform AZURE bootstrap
######################################################################

#AZ CLI = Install the AZ CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

resource_group_name="POC"
location="eastus"
storage_account_name="terraform"
storage_container_name="tfstate"

#Create the resource group
resource_group_exists=$(az group exists --name ${resource_group_name})

if [[ ${resource_group_exists} == "false" ]]; then
    echo "Create resource group: ${resource_group_name}"
    az group create --location ${location} --name ${resource_group_name}
fi

#Create the storage account
storage_account_exists=$(az storage account check-name --name ${storage_account_name} --query "nameAvailable")

if [[ ${storage_account_exists} == "true" ]]; then
    echo "Create storage account: ${storage_account_name}"
    az storage account create \
        --name ${storage_account_name} \
        --resource-group ${resource_group_name} \
        --location ${location} \
        --kind BlobStorage \
        --sku Standard_LRS \
        --https-only $true \
        --allow-blob-public-access $false \
        --min-tls-version TLS1_2
fi

#Create the storage container
storage_account_key=$(az storage account keys list \
    --account-name ${storage_account_name} \
    --query "[0].value")

storage_container_exists=$(az storage container exists \
    --name ${storage_container_name} \
    --account-name ${storage_account_name} \
    --account-key ${storage_account_key} \
    --query "exists")

if [[ ${storage_container_exists} == "false" ]]; then
    echo "Create storage container: ${storage_container_name}"
    az storage container create --name ${storage_container_name} --account-name ${storage_account_name} --account-key ${storage_account_key}
fi
