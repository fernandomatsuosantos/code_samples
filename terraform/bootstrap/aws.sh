#!/bin/bash

######################################################################
# Script Name    : aws.sh
# Description    : Terraform AWS bootstrap
######################################################################

s3_bucket_name="fms-terraform-tfstate"
terraform_iam_user_name="terraform"
dynamodb_table_name="terraform"
secretsmanager_secret_name="terraform"

#AWS CLI = Install the AWS CLI version 2 on Linux
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt -y install zip
unzip -o awscliv2.zip
sudo ./aws/install

#AWS CLI = Confirm the installation
aws --version

#AWS CLI = Configure
aws configure

#S3 bucket = Create the bucket to store terraform file
aws s3api create-bucket --bucket ${s3_bucket_name}
	
#S3 bucket = Enable the server-side encryption
aws s3api put-bucket-encryption \
    --bucket ${s3_bucket_name} \
    --server-side-encryption-configuration={\"Rules\":[{\"ApplyServerSideEncryptionByDefault\":{\"SSEAlgorithm\":\"AES256\"}}]}

#S3 bucket = Enable versioning
aws s3api put-bucket-versioning \
	--bucket ${s3_bucket_name} \
	--versioning-configuration Status=Enabled

#DynamoDB = Create the dynamodb table to be used by terraform
aws dynamodb create-table \
    --table-name  ${dynamodb_table_name} \
    --attribute-definitions \
        AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

#IAM User = Create an IAM user to run Terraform
aws iam create-user \
	--user-name ${terraform_iam_user_name}

#IAM User = we have AdministratorAccess in this situation, but we may have severe restrictions in place in production environments
aws iam attach-user-policy \
	--policy-arn arn:aws:iam::aws:policy/AdministratorAccess \
	--user-name ${terraform_iam_user_name}

#IAM User = get IAM user access key
aws_key=$(aws iam create-access-key --user-name ${terraform_iam_user_name})

#Insert access-key into secretsmanager
aws secretsmanager create-secret \
	--name  ${secretsmanager_secret_name} \
	--description "Terraform Identity and Access Management (IAM) Keys" \
	--secret-string "${aws_key}"