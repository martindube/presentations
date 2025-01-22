#!/bin/bash

PROJECT_NAME="Quebecsec 2024"
PROJECT_ID="quebecsec-2024"
TERRAFORM_BUCKET="gs://quebecsec-2024-bucket"
LOCATION="northamerica-northeast1"

#
# Authenticate to Google
#
gcloud auth application-default login

#
# Création du Projet GCP
#
gcloud projects create "$PROJECT_ID" \
  --folder xxxxx \
  --name "$PROJECT_NAME"

gcloud beta billing projects link "$PROJECT_ID" \
  --billing-account xxx

#
# Activation des API Nécessaires
#
gcloud services enable compute.googleapis.com \
  --project "$PROJECT_ID"
gcloud services enable storage.googleapis.com \
  --project "$PROJECT_ID"
gcloud services enable cloudresourcemanager.googleapis.com \
  --project "$PROJECT_ID"
gcloud services enable secretmanager.googleapis.com \
  --project "$PROJECT_ID"

# Required to upload postfix-docker image
gcloud services enable artifactregistry.googleapis.com \
  --project "$PROJECT_ID"
gcloud services enable cloudbuild.googleapis.com \
  --project "$PROJECT_ID"

# Required for DNS registration and zone management
gcloud services enable domains.googleapis.com \
  --project "$PROJECT_ID"
gcloud services enable dns.googleapis.com \
  --project "$PROJECT_ID"

#
# Setup a bucket for terraform
#
gcloud storage buckets create "$TERRAFORM_BUCKET" \
  --project "$PROJECT_ID" \
  --location "$LOCATION"

#
# Pre-defined secrets
#
echo "xxx" | gcloud secrets create sendgrid-apikey \
  --data-file=- \
  --project "$PROJECT_ID"

echo "mypassword" | gcloud secrets create emails-password \
  --data-file=- \
  --project "$PROJECT_ID"

echo "
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
" | gcloud secrets create postfix-fullchain \
  --data-file=- \
  --project "$PROJECT_ID"

echo "
-----BEGIN PRIVATE KEY-----
...
-----END PRIVATE KEY-----
" | gcloud secrets create postfix-privkey \
  --data-file=- \
  --project "$PROJECT_ID"


#
# Build and push postfix docker image to the project
#
BUILD_LOCATION=us-west2     # https://cloud.google.com/build/docs/locations#restricted_regions_for_some_projects
REPO_NAME=postfix-docker
IMAGE_NAME=$REPO_NAME

# Create repo only once.
gcloud artifacts repositories create $REPO_NAME \
         --repository-format docker \
         --location "$LOCATION" \
         --project "$PROJECT_ID" \
         --description "Docker repository for Postfix-Docker"

# Build and publish
gcloud builds submit \
    --region "$BUILD_LOCATION" \
    --project "$PROJECT_ID" \
    --tag "$LOCATION-docker.pkg.dev/$PROJECT_ID/$REPO_NAME/$IMAGE_NAME"":latest"


#
# Domain registration
#
NEW_DOMAIN="quebecsec.xyz"
NEW_ZONE="quebecsec-xyz-zone"

gcloud dns managed-zones create "$NEW_ZONE" \
  --project "$PROJECT_ID" \
  --description="A new domain for Quebecsec." \
  --dns-name="$NEW_DOMAIN" \
  --visibility=public

gcloud domains registrations register "$NEW_DOMAIN" \
  --project "$PROJECT_ID" \
  --cloud-dns-zone="$NEW_ZONE"