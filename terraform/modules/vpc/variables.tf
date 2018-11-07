variable "source_ranges" {
  description = "Allowed IP addresses"
  default = ["0.0.0.0/0"]
}

variable "name_ssh" {
  description = "Name for rule"
  default = "default-allow-ssh"
}

