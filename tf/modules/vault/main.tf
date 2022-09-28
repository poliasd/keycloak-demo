terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.8.2"
    }
  }
}

provider "vault" {
  address = var.vault_url
  token   = var.vault_token
}

resource "vault_jwt_auth_backend" "keycloak" {
  description        = "Keycloak login"
  path               = "oidc"
  type               = "oidc"
  oidc_discovery_url = "${var.keycloak_host}/auth/realms/${var.realm}"
  oidc_client_id     = var.client_id
  oidc_client_secret = var.client_secret
  default_role       = "default"
  tune {
    default_lease_ttl = "1h"
    max_lease_ttl     = "8h"
    allowed_response_headers     = []
    audit_non_hmac_request_keys  = []
    audit_non_hmac_response_keys = []
    listing_visibility           = "unauth"
    passthrough_request_headers  = []
    token_type                   = "default-service"
  }
}

resource "vault_jwt_auth_backend_role" "default" {
  backend        = vault_jwt_auth_backend.keycloak.path
  role_name      = "default"
  token_policies = ["default"]

  user_claim            = "sub"
  groups_claim          = "groups"
  role_type             = "oidc"
  allowed_redirect_uris = ["${var.vault_url}/oidc/callback", "${var.vault_url}/ui/vault/auth/oidc/oidc/callback"]
}