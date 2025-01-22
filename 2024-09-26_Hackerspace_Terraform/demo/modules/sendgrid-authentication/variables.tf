variable "project" {
  description = "The project ID"
}

variable "dns_zone_name" {
  description = "Name of the zone. Should not contains dots. Example: example-com-zone"
  type        = string
}

variable "domain" {
  description = "Domain name of the zone. Example: example.com"
  type        = string
}

variable "mail_server_ip" {
  description = "External IP address of the mail server"
  type        = string
}

variable "sendgrid_apikey" {
  type        = string
  description = "API Key for sendgrid relay platform."
  sensitive   = true
}