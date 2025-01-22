provider "sendgrid" {
  api_key = var.sendgrid_apikey
}

data "google_dns_managed_zone" "zone" {
  name = var.dns_zone_name
}

resource "sendgrid_domain_authentication" "sendgrid_domain" {
  domain             = var.domain
  ips                = [var.mail_server_ip]
  is_default         = false
  automatic_security = false

  lifecycle {
    ignore_changes = [is_default]
  }
}

# Sendgrid DMARC
resource "google_dns_record_set" "sendgrid_dmarc" {
  name         = "_dmarc.${var.domain}."
  type         = "TXT"
  managed_zone = data.google_dns_managed_zone.zone.name
  rrdatas      = ["\"v=DMARC1; p=none;\""]
  project      = var.project
}

resource "google_dns_record_set" "sendgrid_records" {
  count        = length(sendgrid_domain_authentication.sendgrid_domain.dns)
  name         = "${sendgrid_domain_authentication.sendgrid_domain.dns[count.index].host}."
  type         = upper(sendgrid_domain_authentication.sendgrid_domain.dns[count.index].type)
  managed_zone = data.google_dns_managed_zone.zone.name
  # Ugly hack to remove trailing dot and insert priority in MX record.
  # Pseudocode
  # if startswith(data, "mx.sendgrid.net.")
  #   rrdatas = "10 mx.sendgrid.net."
  # else
  #   rrdatas = data
  rrdatas = [startswith(sendgrid_domain_authentication.sendgrid_domain.dns[count.index].data, "mx.sendgrid.net.") ? "10 mx.sendgrid.net." : "\"${sendgrid_domain_authentication.sendgrid_domain.dns[count.index].data}\""]
  project = var.project
}

# Better validate manually using the WebUI.
# resource "sendgrid_domain_authentication_validation" "validate" {
#     domain_authentication_id = sendgrid_domain_authentication.sendgrid_domain.id
# }

# The fields looks like this:
# sendgrid_records = {
#   "automatic_security" = false
#   "custom_dkim_selector" = ""
#   "custom_spf" = false
#   "dns" = tolist([
#     {
#       "data" = "k=rsa; t=s; p=...."
#       "host" = "m1._domainkey.quebecsec.xyz"
#       "type" = "txt"
#       "valid" = false
#     },
#     {
#       "data" = "v=spf1 include:sendgrid.net ~all"
#       "host" = "em9818.quebecsec.xyz"
#       "type" = "txt"
#       "valid" = false
#     },
#     {
#       "data" = "mx.sendgrid.net."
#       "host" = "em9818.quebecsec.xyz"
#       "type" = "mx"
#       "valid" = false
#     },
#   ])
#   "domain" = "quebecsec.xyz"
#   "id" = "22132138"
#   "ips" = toset([
#     "",
#   ])
#   "is_default" = true
#   "subdomain" = "em9818"
#   "username" = ""
#   "valid" = false
# }
#