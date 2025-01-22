
resource "google_compute_address" "nat_ip" {
  name    = "${var.server_name}-nat-ip"
  project = var.project
}

resource "google_compute_network" "network" {
  name    = "${var.server_name}-network"
  project = var.project
}

resource "google_compute_instance" "vm" {
  name         = "${var.server_name}-vm"
  project      = var.project
  zone         = var.gce_zone
  machine_type = var.gce_machine_type
  # If true, allows Terraform to stop the instance to update its properties.
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 30
      type  = "pd-standard"
    }
  }

  network_interface {
    network = google_compute_network.network.name

    access_config {
      nat_ip = google_compute_address.nat_ip.address
    }
  }

  metadata_startup_script = templatefile("${path.module}/scripts/startup.sh.tftpl",
    {
      fqdn               = "${var.server_name}.${var.domain}"
      operator_user      = var.operator_user
      acme_contact_email = var.acme_contact_email
      allowed_ip_blocks  = "10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,127.0.0.1/8,${var.jumpbox_ip}/32"
  })

  metadata = {
    ssh-keys = "${var.operator_user}:${file(var.ssh_pub_key_file)}"
  }

  # service_account {
  #   email = var.client_email
  #   scopes = [
  #     "https://www.googleapis.com/auth/cloud-platform",
  #   ]
  # }

  lifecycle {
    ignore_changes = [metadata_startup_script, labels]
    #prevent_destroy = true
  }
}
