locals {
  env_variables = [for var_name, var_value in var.env_variables : {
    name  = var_name
    value = var_value
  }]
}

#
# COMPUTE ENGINE
#
resource "google_compute_address" "nat_ip" {
  name    = "${var.server_name}-nat-ip"
  project = var.project
}

resource "google_compute_network" "network" {
  name    = "${var.server_name}-network"
  project = var.project
}

resource "google_compute_instance" "vm" {
  name    = "${var.server_name}-vm"
  project = var.project
  zone    = var.zone
  # gcloud compute machine-types list | grep micro | grep us-central1-a
  # e2-micro / 2 / 1.00
  # f1-micro / 1 / 0.60
  # gcloud compute machine-types list | grep small | grep us-central1-a
  # e2-small / 2 / 2.00
  # g1-small / 1 / 1.70
  machine_type = "e2-micro"
  # If true, allows Terraform to stop the instance to update its properties.
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = module.gce-container.source_image
    }
  }

  network_interface {
    network = google_compute_network.network.name

    access_config {
      nat_ip = google_compute_address.nat_ip.address
    }
  }

  #metadata_startup_script = file("scripts/startup.sh")
  metadata_startup_script = templatefile("${path.module}/scripts/startup.sh.tftpl",
    {
      fullchain       = data.google_secret_manager_secret_version.postfix_fullchain_data.secret_data,
      privkey         = data.google_secret_manager_secret_version.postfix_privkey_data.secret_data,
      email_password  = data.google_secret_manager_secret_version.email_password_data.secret_data,
      sendgrid_apikey = data.google_secret_manager_secret_version.sendgrid_apikey_data.secret_data
  })

  metadata = {
    gce-container-declaration = module.gce-container.metadata_value
    ssh-keys                  = "${var.operator_user}:${file(var.ssh_pub_key_file)}"
  }

  labels = {
    container-vm = module.gce-container.vm_container_label
  }

  service_account {
    email = var.client_email
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  # The image from gce-container could change over time. 
  # Avoid force replacement due to image upgrade.
  lifecycle {
    ignore_changes = [boot_disk[0].initialize_params[0].image]
    #prevent_destroy = true
  }
}

#
# CONTAINER SETUP
#
module "gce-container" {
  # https://github.com/terraform-google-modules/terraform-google-container-vm
  source  = "terraform-google-modules/container-vm/google"
  version = "~> 2.0"

  container = {
    image   = var.image
    command = var.custom_command
    env     = local.env_variables
    securityContext = {
      privileged : var.privileged_mode
    }
    tty : var.activate_tty

    volumeMounts = [
      {
        mountPath = "/run/secrets"
        name      = "secrets"
        readOnly  = false
      },
    ]
  }

  volumes = [
    {
      name = "secrets"
      hostPath = {
        path = "/home/mdube/postfix/secrets"
      }
    },
  ]

  restart_policy = "Always"
}