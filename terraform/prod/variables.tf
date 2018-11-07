variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable "env" {
  description = "Work inveronment for instances"
}

variable "app_tags" {
  description = ["reddit-app", "prod"]

}

variable "db_tags" {
  description = ["reddit-db", "prod"]

}

