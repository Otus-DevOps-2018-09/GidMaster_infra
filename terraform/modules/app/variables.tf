
variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-d"
}

variable app_disk_image {
  description = "Disk image for redit app"
  default = "reddit-app-base"
}

variable "app_ip_name" {
  description = "name for Static IP address"
  default = "reddit-app-ip"
}

variable "app_tags" {
  description = "Tags for App instance"
  default = ["reddit-app"]
}

variable "fw_app_rule_name" {
  description = "Firewall rule name"
  default = "allow-app-default"
}

variable "redit-app" {
  description = "Application instance name"
  default = "redit-app"
}

