
resource "google_compute_firewall" "ssh-rule" {
  name    = "${google_compute_network.network.name}-allow-ssh"
  project = var.project

  network = google_compute_network.network.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  #target_tags = ["demo-vm-instance"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "smtp-rule" {
  name    = "${google_compute_network.network.name}-allow-smtp"
  project = var.project

  network = google_compute_network.network.name
  allow {
    protocol = "tcp"
    ports    = ["25", "587"]
  }
  #target_tags = ["demo-vm-instance"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "imap-rule" {
  name    = "${google_compute_network.network.name}-allow-imap"
  project = var.project

  network = google_compute_network.network.name
  allow {
    protocol = "tcp"
    ports    = ["993"]
  }
  #target_tags = ["demo-vm-instance"]
  source_ranges = ["0.0.0.0/0"]
}