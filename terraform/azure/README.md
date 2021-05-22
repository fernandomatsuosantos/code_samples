# Azure Terraform POC

-   Deploy Azure Kubernetes Service (AKS) 
-   Deploy PostgreSQL

This repository contains HashiCorp Terraform configuration required to create resources at Azure.

## Prerequisites

-   [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) installed.
-   [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) installed.
-   HashiCorp [Terraform](https://terraform.io/downloads.html) installed.
-   Terraform version: `0.13.x`
-   [Azure Provider](https://www.terraform.io/docs/providers/azurerm/index.html) version: `2.34`

### Clone the Github repository

```bash
git clone git@github.com:fernandomatsuosantos/code_samples.git
```

## Tutorial

Generate Azure client id and secret.

```bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/YOUR_SUBSCRIPTION_ID"
```

Expected output:

```bash
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "azure-cli-xxxx-xx-xx-xx-xx-xx",
  "name": "http://azure-cli-xxxx-xx-xx-xx-xx-xx",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}
```

`appId` = Client id.
`password` = Client secret.
`tenant` = Tenant id.

Export environment variables to configure the [Azure](https://www.terraform.io/docs/providers/azurerm/index.html) Terraform provider.

```bash
export ARM_SUBSCRIPTION_ID="YOUR_SUBSCRIPTION_ID"
export ARM_TENANT_ID="TENANT_ID"
export ARM_CLIENT_ID="CLIENT_ID"
export ARM_CLIENT_SECRET="CLIENT_SECRET"
```

Note: If you are using Windows replace "export" to "$ENV:" at powershell

Run Terraform init and plan.

```bash
terraform init
```

```bash

Initializing modules...

Initializing the backend...

Initializing provider plugins...
- Using previously-installed hashicorp/azurerm v2.34.0
- Using previously-installed hashicorp/tls v3.0.0
- Using previously-installed hashicorp/local v2.0.0

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, we recommend adding version constraints in a required_providers block
in your configuration, with the constraint strings suggested below.

* hashicorp/local: version = "~> 2.0.0"
* hashicorp/tls: version = "~> 3.0.0"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

```bash
terraform plan
```

```bash
terraform apply
```

- Note: Creating an Azure AKS cluster can take up to 10/15 minutes.  

Configure kubeconfig

Instructions can be obtained by running the following command

```bash
terraform output configure

Run the following commands to configure kubernetes client:

$ terraform output kube_config > ~/.kube/aksconfig
$ export KUBECONFIG=~/.kube/aksconfig
Note: If you are using Windows replace "export" to "$ENV:" at powershell

Test configuration using kubectl

$ kubectl get nodes
```

```bash
NAME                              STATUS   ROLES   AGE     VERSION
aks-default-36958969-vmss000000   Ready    agent   7m22s   v1.17.11
```

## PostgreSQL

A PostgreSQL database will be created and you can connect to the service using Dbeaver (for example)
<https://dbeaver.io/download/>

You can get the connection string at Azure portal.
