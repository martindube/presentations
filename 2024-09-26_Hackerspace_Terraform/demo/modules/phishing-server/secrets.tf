data "google_secret_manager_secret_version" "postfix_fullchain_data" {
  secret = "postfix-fullchain"
}

data "google_secret_manager_secret_version" "postfix_privkey_data" {
  secret = "postfix-privkey"
}

data "google_secret_manager_secret_version" "email_password_data" {
  secret = "emails-password"
}

data "google_secret_manager_secret_version" "sendgrid_apikey_data" {
  secret = "sendgrid-apikey"
}