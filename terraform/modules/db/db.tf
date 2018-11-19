resource "google_compute_instance" "db" {
  name         = "${var.reddit-db}"
  machine_type = "f1-micro"
  zone         = "${var.zone}"
  tags         = "${var.db_tags}"

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  
  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file("${var.private_key_path}")}"
  } 

  provisioner "remote-exec" {
    inline = [
      "sudo -- sh -c 'sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf && systemctl restart mongod'"
    ]
  }
}

resource "google_compute_firewall" "firewall_mongo" {
  name    = "${var.fw_db_rule_name}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  source_tags = "${var.app_tags}"
  target_tags = "${var.db_tags}"
}
