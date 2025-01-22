data "google_dns_managed_zone" "zone" {
  name = var.dns_zone_name
}

resource "google_dns_record_set" "spf" {
  name         = data.google_dns_managed_zone.zone.dns_name
  type         = "TXT"
  managed_zone = data.google_dns_managed_zone.zone.name
  rrdatas = ["\"v=spf1 ip4:${google_compute_address.nat_ip.address}/32 ~all\""]
  project = var.project
}

resource "google_dns_record_set" "dmarc" {
  name         = "_dmarc.${data.google_dns_managed_zone.zone.dns_name}"
  type         = "TXT"
  managed_zone = data.google_dns_managed_zone.zone.name
  rrdatas      = ["\"v=DMARC1; p=none;\""]
  project      = var.project
}

resource "google_dns_record_set" "mail" {
  name         = "${var.mail_dns_hostname}."
  type         = "A"
  managed_zone = data.google_dns_managed_zone.zone.name
  rrdatas      = ["${google_compute_address.nat_ip.address}"]
  project      = var.project
}

resource "google_dns_record_set" "mx" {
  name         = data.google_dns_managed_zone.zone.dns_name
  type         = "MX"
  managed_zone = data.google_dns_managed_zone.zone.name
  rrdatas      = ["10 ${google_dns_record_set.mail.name}"]
  project      = var.project
}
