terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.4.0"
    }
    sendgrid = {
      source  = "octoenergy/sendgrid"
      version = "1.0.7"
    }
  }
  backend "gcs" {
    bucket = "quebecsec-2024-bucket"
    prefix = "terraform/state"
  }
}
