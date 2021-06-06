# AWS Terraform POC

-   Deploy AWS Config and services necessary to AWS Config (S3 bucket, policies, IAM rule)
-   Deploy Security Hub
-   Deploy GuardDuty

This repository contains HashiCorp Terraform configuration required to create resources at AWS.

## Prerequisites

-   HashiCorp [Terraform](https://terraform.io/downloads.html) installed.
-   Terraform version: `0.15.5`

### Clone the Github repository

```bash
git clone git@github.com:fernandomatsuosantos/code_samples.git
```

## Tutorial

Create an IAM user to be used by terraform and copy the Access keys (access key ID and secret access key)

Export environment variables:

```bash
export AWS_ACCESS_KEY_ID="an-access-key"
export AWS_SECRET_ACCESS_KEY="a-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

Note: If you are using Windows replace "export" to "$ENV:" at powershell

Run Terraform init and plan.

```bash
terraform init 
```

```bash
Initializing modules...
- config in ..\..\modules\config
- iam_role in ..\..\modules\iam_role
- s3 in ..\..\modules\s3
- s3_bucket_policy in ..\..\modules\s3_bucket_policy
- security_hub in ..\..\modules\security_hub

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v3.39.0...
- Installed hashicorp/aws v3.39.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

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

_The resources AWS Config, Security Hub and Deploy GuardDuty will be created at AWS._
