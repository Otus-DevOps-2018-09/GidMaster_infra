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
  default = ["reddit-app", "prod"]
}

variable "db_tags" {
  default = ["reddit-db", "prod"]
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
}

variable "db_disk_image" {
  description = "Disk image for redit db"
}