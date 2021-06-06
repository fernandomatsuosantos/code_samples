#!/bin/bash

######################################################################
# Script Name    : azure.sh
# Description    : Terraform AZURE bootstrap
######################################################################

# Stop execution on any error
#set -e

resource_group_name="poc-terraform-tfstate"
location="eastus"
storage_account_name="pocfmsterraform"
storage_container_name="tfstate"

# Create the resource group
resource_group_exists=$(az group exists --name "${resource_group_name}")

if [[ ${resource_group_exists} == "false" ]]; then
    echo "Create resource group: ${resource_group_name}"
    az group create --location "${location}" --name "${resource_group_name}"
fi

# Create the storage account
storage_account_exists=$(az storage account check-name --name "${storage_account_name}" --query "nameAvailable")

if [[ ${storage_account_exists} == "true" ]]; then
    echo "Create storage account: ${storage_account_name}"
    az storage account create \
        --name "${storage_account_name}" \
        --resource-group "${resource_group_name}" \
        --location "${location}" \
        --kind BlobStorage \
        --sku Standard_LRS \
        --https-only true \
        --allow-blob-public-access false \
        --min-tls-version TLS1_2 \
        --access-tier hot 

    # Enable versioning
    # https://docs.microsoft.com/en-us/azure/storage/blobs/versioning-overview
    az storage account blob-service-properties update \
        --account-name "${storage_account_name}"  \
        --resource-group "${resource_group_name}" \
        --enable-versioning true \
        --enable-delete-retention true \
        --delete-retention-days 30 \
        --container-retention true \
        --container-days 30

    # Delete old versions
    # https://docs.microsoft.com/en-us/azure/storage/blobs/storage-lifecycle-management-concepts?tabs=azure-portal
    az storage account management-policy create \
        --account-name "${storage_account_name}"  \
        --resource-group "${resource_group_name}" \
        --policy @azure_delete_old_versions.json
fi

# Create the storage container
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
