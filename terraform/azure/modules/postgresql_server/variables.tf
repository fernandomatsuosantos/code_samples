variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "name" {
  description = "Specifies the name of the PostgreSQL Server"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the PostgreSQL Server"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists"
}

variable "sku_name" {
  description = "Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)."
}

variable "storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs. "
}

variable "backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
}
variable "geo_redundant_backup_enabled" {
  default     = "false"
  description = "Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not support for the Basic tier."
}

variable "auto_grow_enabled" {
  default     = "true"
  description = "Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true."
}

variable "administrator_login" {
  description = "The Administrator Login for the PostgreSQL Server"
}

variable "administrator_login_password" {
  description = "The Password associated with the administrator_login for the PostgreSQL Server."
}

variable "postgresql_server_version" {
  description = "Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, 10, 10.0, and 11"
}

variable "ssl_enforcement" {
  default     = "Enabled"
  description = "Specifies if SSL should be enforced on connections."
}

variable "postgresql_firewall_start_ip_address" {
  description = "Specifies the Start IP Address associated with this Firewall Rule"
  default     = "0.0.0.0"
}

variable "postgresql_firewall_end_ip_address" {
  description = "Specifies the End IP Address associated with this Firewall Rule"
  default     = "255.255.255.255"
}

variable "infrastructure_encryption_enabled" {
  description = "Whether or not infrastructure is encrypted for this server. Defaults to false"
  default     = "false"
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this server. Defaults to true"
  default     = "true"
}

variable "ssl_enforcement_enabled" {
  description = "Specifies if SSL should be enforced on connections. Possible values are true and false."
  default     = "true"
}

variable "ssl_minimal_tls_version_enforced" {
  description = "The mimimun TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLSEnforcementDisabled."
  default     = "TLS1_2"
}

variable "threat_detection_policy_enabled" {
  description = "Is the policy enabled"
  default     = false
}
