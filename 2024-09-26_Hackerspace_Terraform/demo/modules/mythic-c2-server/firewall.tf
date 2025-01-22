resource "google_compute_firewall" "ssh-rule" {
  name    = "${google_compute_network.network.name}-allow-ssh"
  project = var.project

  network = google_compute_network.network.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "http-https-rule" {
  name    = "${google_compute_network.network.name}-allow-http-https"
  project = var.project

  network = google_compute_network.network.name
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "msf-8081" {
  name    = "${google_compute_network.network.name}-allow-8081"
  project = var.project

  network = google_compute_network.network.name
  allow {
    protocol = "tcp"
    ports    = ["8081"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# resource "google_compute_firewall" "rabbitmq" {
#   name    = "${google_compute_network.network.name}-rabbitmq"
#   project = var.project

#   network = google_compute_network.network.name
#   allow {
#     protocol = "tcp"
#     ports    = ["5672"]
#   }
#   source_ranges = ["${var.developer_ip}/32"]
# }

# resource "google_compute_firewall" "mythic_backend" {
#   name    = "${google_compute_network.network.name}-mythic-backend"
#   project = var.project

#   network = google_compute_network.network.name
#   allow {
#     protocol = "tcp"
#     ports    = ["17443"]
#   }
#   source_ranges = ["${var.developer_ip}/32"]
# }

resource "google_compute_firewall" "impacket_445" {
  name    = "${google_compute_network.network.name}-impacket-smbserver"
  project = var.project

  network = google_compute_network.network.name
  allow {
    protocol = "tcp"
    ports    = ["445"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "dnsspoof_tcp_53" {
  name    = "${google_compute_network.network.name}-dnsspoof-tcp-53"
  project = var.project

  network = google_compute_network.network.name
  allow {
    protocol = "tcp"
    ports    = ["53"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "dnsspoof_udp_53" {
  name    = "${google_compute_network.network.name}-dnsspoof-udp-53"
  project = var.project

  network = google_compute_network.network.name
  allow {
    protocol = "udp"
    ports    = ["53"]
  }
  source_ranges = ["0.0.0.0/0"]
}
