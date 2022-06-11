remote_state {
  backend = "local"
  config = {
    path = "/project/tfstate/${path_relative_to_include()}/terraform.tfstate"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
  provider "vault" {
    skip_tls_verify     = true
  }
  data "vault_generic_secret" "password" {
    path = "secret/jenkinstest/password"
  }
  provider "vsphere" {
    user                 = "administrator@vsphere.local"
    password             = data.vault_generic_secret.password.data["password"]
    vsphere_server       = "192.168.50.65"
    allow_unverified_ssl = true
  }
  terraform {
        backend "local" {}
    }
  EOF
}