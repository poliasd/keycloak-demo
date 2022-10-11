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

resource "keycloak_oidc_identity_provider" "gitlab_identity_provider" {
  realm                         = var.realm_id
  alias                         = "gitlab"
  authorization_url             = "https://gitlab.com/"
  client_id                     = var.gitlab_client_id
  client_secret                 = var.gitlab_client_secret
  token_url                     = "https://gitlab.com/site/oauth2/access_token"
  provider_id                   = "gitlab"
  trust_email                   = "true"
  store_token                   = "false"
  default_scopes                = ""
  sync_mode                     = "IMPORT"
  first_broker_login_flow_alias = "browser"
  post_broker_login_flow_alias  = "post login"
}

resource "keycloak_custom_identity_provider_mapper" "oidc" {
  realm                    = var.realm_id
  name                     = "emailDomain"
  identity_provider_alias  = keycloak_oidc_identity_provider.gitlab_identity_provider.alias
  identity_provider_mapper = "hardcoded-user-session-attribute-idp-mapper"

  # extra_config with syncMode is required in Keycloak 10+
  extra_config = {
    "attribute.value" = "gmail.com"
    "attribute"       = "emailDomain"
  }
}