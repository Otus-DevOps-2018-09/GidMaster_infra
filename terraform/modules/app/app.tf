resource "google_compute_instance" "app" {
  name         = "${var.reddit-app}"
  machine_type = "f1-micro"
  zone         = "${var.zone}"
  tags         = "${var.app_tags}"

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_address" "app_ip" {
  name = "${var.app_ip_name}"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "${var.fw_app_rule_name}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = "${var.app_tags}"
}
