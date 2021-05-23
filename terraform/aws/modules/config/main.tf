# Create the AWS Config
resource "aws_config_configuration_recorder" "config_configuration_recorder" {
  name     = var.name
  role_arn = var.role_arn

  recording_group {
    all_supported                 = var.recording_group_all_supported
    include_global_resource_types = var.recording_group_include_global_resource_types
  }
}

resource "aws_config_delivery_channel" "config_delivery_channel" {
  name           = aws_config_configuration_recorder.config_configuration_recorder.id
  s3_bucket_name = var.cdc_s3_bucket_name

  snapshot_delivery_properties {
    delivery_frequency = var.cdc_snapshot_delivery_properties_delivery_frequency
  }
}

resource "aws_config_configuration_recorder_status" "config_configuration_recorder_status" {
  name       = aws_config_delivery_channel.config_delivery_channel.name
  is_enabled = var.ccrs_is_enabled
}
