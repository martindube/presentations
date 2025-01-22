# Presentation notes

## 0. Authentification

```bash
gcloud auth application-default login
#gcloud compute ssh "mail-vm"
#gcloud compute ssh "c2-vm"
#ssh vps...
```

## 1. Preparation

Go through [_setup.sh](./_setup.sh)


## 2. Terraform 101

```bash
terraform validate
terraform fmt
```


## 3. Deploy phishing box

Deploy

```bash
terraform plan -out /tmp/planfile \
                -target=module.phishing
terraform apply /tmp/planfile
```

<!-- 
Sendgrid authentication

```bash
terraform plan -out /tmp/planfile \
                -target="module.sendgrid.sendgrid_domain_authentication.sendgrid_domain"
terraform apply /tmp/planfile
``` -->

Verify

```bash
gcloud compute ssh "mail-vm"

# Connect using Thunderbird
# Servers: mail.quebecsec.xyz
# Username: mdube
# IMAP: Port 933, SSL/TLS
# SMTP: Port 587, STARTTLS
```


## 4. Update the infrastructure in place

Update

```bash
terraform taint module.phishing.google_compute_address.nat_ip
terraform plan -out /tmp/planfile \
                -target=module.phishing
terraform apply /tmp/planfile
```

Verify

```bash
terraform show
```


## 5. Deploy C2 box

Deploy

```bash
terraform plan -out /tmp/planfile \
                -target=module.c2
terraform apply /tmp/planfile
```

Monitor

```bash
gcloud compute ssh "c2-vm"
sudo journalctl -xef _PID=812
```

Login
```bash
cd /opt/mythic
sudo ./mythic-cli config get mythic_admin
```


## 6. Destroy everything

Deploy

```bash
terraform destroy
```
