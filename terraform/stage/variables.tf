variable "project" {
  description = "Project ID"
}

variable "region" {
  description = "Region"
  default     = "europe-west1"
}

variable "env" {
  description = "Work inveronment for instances"
}

variable "app_tags" {
  default = ["reddit-app", "stage", "app"]
}

variable "db_tags" {
  default = ["reddit-db", "stage", "db"]
}

variable "public_key_path" {
  description = "Work Path to public key"
}

variable "zone" {
  description = "Zone"
  default     = "europe-west1-d"
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
