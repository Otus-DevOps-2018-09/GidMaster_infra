provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source           = "../modules/app"
  public_key_path  = "${var.public_key_path}"
  zone             = "${var.zone}"
  app_disk_image   = "${var.app_disk_image}"
  app_ip_name      = "reddit-app-ip-${var.env}"
  fw_app_rule_name = "allow-app-default-${var.env}"
  app_tags         = "${var.app_tags}"
  redit-app        = "redit-app-${var.env}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
  fw_db_rule_name = "allow-mongo-default-${var.env}"
  db_tags         = "${var.db_tags}"
  app_tags        = "${var.app_tags}"
  reddit-db       = "reddit-db-${var.env}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["109.194.34.184/32"]
  name_ssh      = "default-allow-ssh-${var.env}"
}
