data "digitalocean_ssh_key" "terraform" {
  name = "service_key_do" # Will be taken from DO
}