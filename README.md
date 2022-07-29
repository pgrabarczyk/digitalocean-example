# digitalocean-example

## Requirements
* https://github.com/tfutils/tfenv
* https://docs.digitalocean.com/reference/doctl/how-to/install/

## Before first run

```bash
# https://github.com/tfutils/tfenv
tfenv install
terrafom version
```

```bash
# https://docs.digitalocean.com/reference/doctl/how-to/install/
doctl auth init --context <NAME>
doctl auth switch --context <NAME>
doctl account get
```

```bash
DIGITALOCEAN_ACCESS_TOKEN=$(cat $HOME/.config/doctl/config.yaml | grep "private:" | cut -d' ' -f4)
export DIGITALOCEAN_ACCESS_TOKEN=$DIGITALOCEAN_ACCESS_TOKEN
```

```bash
 
# Below should generate service_key_do & service_key_do.pub
ssh-keygen -t rsa -C "your_email@example.com" -f "./service_key_do"

# Load public key to DO
doctl compute ssh-key import "service_key_do" --public-key-file "service_key_do.pub"
```

## Run

#### Create infra
```bash
# cd infra/envs/dev/
terraform init
terraform plan -var "do_token=$DIGITALOCEAN_ACCESS_TOKEN" -out ".terraform.plan.out"
terraform apply ".terraform.plan.out"
```

#### SSH into ubuntu droplet
```bash
# SSH into new machine
IP_ADDRESS=$(terraform output | cut -d'"' -f2)
ssh terraform@$IP_ADDRESS -i "../../../service_key_do"

# Note. Apache2 server may be down / configuring for ~3minutes after terraform apply
```

#### Destroy infra
```bash
terraform destroy -var "do_token=$DIGITALOCEAN_ACCESS_TOKEN"
```

## Helpful links:
https://learn.hashicorp.com/tutorials/terraform/digitalocean-provider?in=terraform/applications
https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
https://www.w3schools.com/w3css/w3css_templates.asp
https://docs.digitalocean.com/reference/doctl/reference/compute/region/list/


