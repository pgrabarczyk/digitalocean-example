resource "digitalocean_droplet" "service_A" {
  image     = "ubuntu-22-04-x64" # doctl compute image list-distribution
  name      = "serviceA"
  region    = "lon1" # London 1 # doctl compute region list
  size      = "s-1vcpu-1gb" # doctl compute size list
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  user_data = file("service_A.yaml")
}