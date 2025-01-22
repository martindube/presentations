
variable "server_name" {
  description = "The desired name to assign to the deployed instance"
}

variable "project" {
  description = "The project ID"
}

variable "domain" {
  type = string
}

variable "dns_zone_name" {
  description = "Name of the zone. Should not contains dots. Example: example-com-zone"
  type = string
}

variable "gce_zone" {
  type = string
}

variable "gce_machine_type" {
  type    = string
  default = "e2-medium"
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

variable "acme_contact_email" {
  description = "The contact email used by acme.sh"
  type        = string
}

variable "jumpbox_ip" {
  description = "The IPv4 address of the jumpbox. Mythic login will be allowed from this IP."
  type        = string
  default     = ""
}

variable "developer_ip" {
  description = "Allow development ports such as rabbitmq (5432) and mythic grpc (17444)."
  type        = string
  default     = ""
}


