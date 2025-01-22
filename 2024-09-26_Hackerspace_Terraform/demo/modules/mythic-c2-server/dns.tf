data "google_dns_managed_zone" "zone" {
  name = var.dns_zone_name
}

# Sync NS between registrat and zone authority.
# resource "google_dns_record_set" "name_servers" {
#   name         = data.google_dns_managed_zone.zone.dns_name
#   type         = "NS"
#   managed_zone = data.google_dns_managed_zone.zone.name
#   rrdatas      = [for d in google_clouddomains_registration.default.dns_settings[0].custom_dns[0].name_servers : "${d}."]
#   project      = var.project
# }

resource "google_dns_record_set" "server_name" {
  name         = "${var.server_name}.${data.google_dns_managed_zone.zone.dns_name}"
  type         = "A"
  managed_zone = data.google_dns_managed_zone.zone.name
  rrdatas      = ["${google_compute_address.nat_ip.address}"]
  project      = var.project
}

resource "google_dns_record_set" "cookies" {
  name         = "cookies.${data.google_dns_managed_zone.zone.dns_name}"
  type         = "A"
  managed_zone = data.google_dns_managed_zone.zone.name
  rrdatas      = ["${google_compute_address.nat_ip.address}"]
  project      = var.project
}

resource "google_dns_record_set" "www" {
  name         = "www.${data.google_dns_managed_zone.zone.dns_name}"
  type         = "A"
  managed_zone = data.google_dns_managed_zone.zone.name
  rrdatas      = ["${google_compute_address.nat_ip.address}"]
  project      = var.project
}

resource "google_dns_record_set" "files" {
  name         = "files.${data.google_dns_managed_zone.zone.dns_name}"
  type         = "A"
  managed_zone = data.google_dns_managed_zone.zone.name
  rrdatas      = ["${google_compute_address.nat_ip.address}"]
  project      = var.project
}

# resource "google_dns_record_set" "default" {
#   name         = "${data.google_dns_managed_zone.zone.dns_name}"
#   type         = "A"
#   managed_zone = data.google_dns_managed_zone.zone.name
#   rrdatas      = ["${google_compute_address.nat_ip.address}"]
#   project      = var.project
# }