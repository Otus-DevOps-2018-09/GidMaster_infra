variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "zone" {
  description = "Zone"
  default     = "europe-west1-d"
}

variable "db_disk_image" {
  description = "Disk image for reddit db",
  default = "reddit-db-base"
}

variable "db_tags" {
  description = "Tags for DB instance"
  default = ["reddit-db"]
}

variable "app_tags" {
  description = "Tags for App instance"
  default = ["reddit-app"]
}

variable "fw_db_rule_name" {
  description = "Firewall rule name"
  default = "allow-mongo-default"
}

variable "redit-db" {
  description = "DB instance Name"
  default = "reddit-db"
}
