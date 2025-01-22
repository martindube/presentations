provider "google" {
  region  = var.gce_region
  project = var.project_id
}

# GCP doesn't allow underscores or dots in names.
locals {
  mail_server_name  = "mail"
  mail_dns_hostname = "mail.${var.my_domain}"
  mail_docker_image = "${var.gce_region}-docker.pkg.dev/${var.project_id}/postfix-docker/postfix-docker:latest"
  c2_server_name    = "c2"
}

module "phishing" {
  source          = "./modules/phishing-server"
  image           = local.mail_docker_image
  zone            = var.gce_zone
  privileged_mode = true
  activate_tty    = true

  env_variables = {
    PRIMARY_DOMAIN   = var.my_domain
    PRIMARY_HOSTNAME = local.mail_dns_hostname
    RELAY_HOST       = "[${var.smtp_relay_hostname}]:${var.smtp_relay_port}"
  }
  server_name = local.mail_server_name
  project     = var.project_id

  ssh_pub_key_file = "${var.SSH_KEY_PATH}.pub"

  mail_dns_hostname = local.mail_dns_hostname
  dns_zone_name     = var.my_domain_zone
  domain            = var.my_domain
}

module "c2" {
  source   = "./modules/mythic-c2-server"
  domain   = var.my_domain
  gce_zone = var.gce_zone

  server_name        = local.c2_server_name
  project            = var.project_id
  acme_contact_email = var.acme_contact_email
  dns_zone_name      = var.my_domain_zone

  ssh_pub_key_file = "${var.SSH_KEY_PATH}.pub"
}




# #
# # Skip for Quebecsec. Not working.
# #
# data "google_secret_manager_secret_version" "sendgrid_apikey_data" {
#   secret = "sendgrid-apikey"
# }

# module "sendgrid" {
#   source         = "./modules/sendgrid-authentication"
#   project        = var.project_id
#   dns_zone_name  = var.my_domain_zone
#   mail_server_ip = module.phishing.nat_ip
#   domain         = var.my_domain

#   # Secrets
#   sendgrid_apikey   = data.google_secret_manager_secret_version.sendgrid_apikey_data.secret_data
# }