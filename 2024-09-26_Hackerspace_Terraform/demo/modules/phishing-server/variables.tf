variable "server_name" {
  description = "The desired name to assign to the deployed instance"
  default     = "disk-instance-vm-test"
}

variable "project" {
  description = "The project ID"
}

variable "image" {
  description = "The Docker image to deploy to GCE instances"
}

variable "env_variables" {
  type    = map(string)
  default = null
}

variable "privileged_mode" {
  type    = bool
  default = false
}

variable "activate_tty" {
  type    = bool
  default = false
}

variable "custom_command" {
  type    = list(string)
  default = null
}

variable "additional_metadata" {
  type        = map(string)
  description = "Additional metadata to attach to the instance"
  default     = null
}

variable "client_email" {
  description = "Service account email address"
  type        = string
  default     = null
}

variable "zone" {
  type    = string
  default = "northamerica-northeast1-a"
}

variable "machine_type" {
  type    = string
  default = "e2-small"
}

# TODO: Determine automatically?
variable "operator_user" {
  type        = string
  description = "Default username. It should be your google account."
  default     = ""
}

variable "ssh_pub_key_file" {
  type        = string
  description = "SSH Public key file that will be added to the GCE VM at creation."
}

#
# 
#
variable "dns_zone_name" {
  description = "Name of the zone. Should not contains dots. Example: example-com-zone"
  type        = string
}

variable "mail_dns_hostname" {
  description = "FQDN of the mail server. Example: mail.example.com"
  type        = string
}

variable "domain" {
  description = "Domain name of the zone. Example: example.com"
  type        = string
}
