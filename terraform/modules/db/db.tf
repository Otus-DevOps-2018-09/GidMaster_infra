resource "google_compute_instance" "db" {
  name = "reddit-db"
  machine_type = "f1-micro"
  zone = "${var.zone}"
  tags = "${var.db_tags}"
  boot_disk {
      initialize_params {
          image = "${var.db_disk_image}"
      }
  }
  network_interface {
      network = "default"
      access_config = {}
  }
  metadata {
      ssh-keys = "gcp.syrovatsky:${file(var.public_key_path)}"
  }
}
resource "google_compute_firewall" "firewall_mongo" {
  name = "${var.fw_db_rule_name}"
  network = "default"
  allow {
      protocol = "tcp"
      ports = ["27017"]
  }
  source_tags = "${var.app_tags}"
  target_tags = "${var.db_tags}"
}

