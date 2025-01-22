#
# Global vars
#

variable "project_id" {
  type    = string
  default = "quebecsec-2024"
}

variable "gce_region" {
  type    = string
  default = "northamerica-northeast1" # Montreal
}

variable "gce_zone" {
  type    = string
  default = "northamerica-northeast1-a"
}

variable "gce_machine_type" {
  type    = string
  default = "e2-small"
}

variable "gcp_service_list" {
  description = "The list of apis necessary for the project"
  type        = list(string)
  default = [
    "domains.googleapis.com",
    "dns.googleapis.com",
    "compute.googleapis.com",
    "secretmanager.googleapis.com",
    "artifactregistry.googleapis.com",
    "publicca.googleapis.com"
    # "run.googleapis.com",     # run.
    # "cloudresourcemanager.googleapis.com",  # Required for gcr.io
  ]
}

variable "my_domain" {
  type    = string
  default = "quebecsec.xyz"
}

variable "my_domain_zone" {
  type    = string
  default = "quebecsec-xyz-zone"
}


variable "smtp_relay_hostname" {
  description = "Hostname of the smtp relay server. Ex: smtp.gmail.com"
  type        = string
  default     = "smtp.sendgrid.net"
}

variable "smtp_relay_port" {
  description = "Port of the smtp relay server. Avoid using port 25 as it is blocked in gcloud. Use port 587."
  type        = string
  default     = "587"
}

#
# MISC
#
variable "SSH_KEY_PATH" {
  description = "The path to the ssh key (Not .pub)"
  type        = string
  default     = "/work/.ssh/id_ed25519"
}

variable "acme_contact_email" {
  description = "The contact email used by acme.sh"
  type        = string
  default     = ""
}