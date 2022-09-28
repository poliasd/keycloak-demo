terraform {
  required_version = ">= 0.13"

  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 3.10.0"
    }
  }
}

provider "keycloak" {
  client_id     = var.keycloak_client_id
  username      = var.keycloak_username
  password      = var.keycloak_password
  url           = var.keycloak_url
}

provider "vault" {
    address = var.vault_url
    auth_login {
    path = "auth/userpass/login/${var.vault_username}"

    parameters = {
      password = var.vault_password
    }
  }
}