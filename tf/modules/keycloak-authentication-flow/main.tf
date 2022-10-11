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

resource "keycloak_authentication_flow" "flow" {
  realm_id = var.realm_id
  alias    = "post login"
}

resource "keycloak_authentication_execution" "execution" {
  realm_id          = var.realm_id
  parent_flow_alias = keycloak_authentication_flow.flow.alias
  authenticator     = "script-email-domain-verifier.js"
  requirement       = "ALTERNATIVE"
}