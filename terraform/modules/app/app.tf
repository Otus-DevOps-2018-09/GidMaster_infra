resource "google_compute_instance" "app" {
  name         = "${var.redit-app}"
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
    ssh-keys = "gcp.syrovatsky:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "gcp.syrovatsky"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "../modules/app/files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'export DATABASE_URL=${var.reddit_db_addr}' > /home/gcp.syrovatsky/.bash_profile",
      "chown gcp.syrovatsky:gcp.syrovatsky /home/gcp.syrovatsky/.bash_profile"
    ]
  }

  provisioner "remote-exec" {
    script = "../modules/app/files/deploy.sh"
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
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = "${var.app_tags}"
}
