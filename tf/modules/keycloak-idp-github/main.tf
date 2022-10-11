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

resource "keycloak_oidc_identity_provider" "bitbucket_identity_provider" {
  realm             = var.realm_id
  alias             = "github"
  authorization_url = "https://github.com/"
  client_id         = var.github_client_id
  client_secret     = var.github_client_secret
  token_url         = "https://bitbucket.org/site/oauth2/access_token"
  provider_id       = "github"
  trust_email       = "true"
  store_token       = "false"
  default_scopes    = ""
  sync_mode         = "IMPORT"
}