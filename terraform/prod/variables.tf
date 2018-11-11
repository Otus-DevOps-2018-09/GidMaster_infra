variable "project" {
  description = "Project ID"
}

variable "region" {
  description = "Region"
  default     = "us-east1"
}

variable "env" {
  description = "Work inveronment for instances"
}

variable "app_tags" {
  default = ["reddit-app", "prod"]
}

variable "db_tags" {
  default = ["reddit-db", "prod"]
}

variable "public_key_path" {
  description = "Work Path to public key"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable "zone" {
  description = "Zone"
  default     = "us-east1-b"
}

variable "app_disk_image" {
  description = "Disk image for redit app"
  default     = "reddit-app-base"
}

variable "db_disk_image" {
  description = "Disk image for redit db"
  default     = "reddit-db-base"
}

variable "bucket" {
  description = "bucket name for backup state file"
}
