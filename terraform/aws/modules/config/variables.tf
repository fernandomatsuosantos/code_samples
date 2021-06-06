variable "name" {
  description = "The name of the recorder. Defaults to default. Changing it recreates the resource."
}

variable "role_arn" {
  description = "Amazon Resource Name (ARN) of the IAM role. Used to make read or write requests to the delivery channel and to describe the AWS resources associated with the account. See AWS Docs for more details."
}

variable "recording_group_all_supported" {
  description = "Specifies whether AWS Config records configuration changes for every supported type of regional resource (which includes any new type that will become supported in the future). Conflicts with resource_types. Defaults to true."
}

variable "recording_group_include_global_resource_types" {
  description = "Specifies whether AWS Config includes all supported types of global resources with the resources that it records. Requires all_supported = true. Conflicts with resource_types."
}

variable "cdc_s3_bucket_name" {
  description = "The name of the S3 bucket used to store the configuration history."
}

variable "cdc_snapshot_delivery_properties_delivery_frequency" {
  description = "The frequency with which AWS Config recurringly delivers configuration snapshots. e.g. One_Hour or Three_Hours."
}

variable "ccrs_is_enabled" {
  description = "Whether the configuration recorder should be enabled or disabled."
}