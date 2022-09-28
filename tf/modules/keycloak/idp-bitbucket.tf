#Configure Bitbucket as Identity provider

resource "keycloak_oidc_identity_provider" "bitbucket_identity_provider" {
  realm             = keycloak_realm.realm.id
  alias             = "bitbucket"
  authorization_url = "https://bitbucket.org/"
  client_id         = var.bitbucket_client_id
  client_secret     = var.bitbucket_client_secret
  token_url         = "https://bitbucket.org/site/oauth2/access_token"
  provider_id       = "bitbucket"
  trust_email       = "true"
  store_token       = "false"
  default_scopes    = ""
  sync_mode         = "IMPORT"
}

resource "keycloak_custom_identity_provider_mapper" "oidc_email_mapper" {
  realm        = keycloak_realm.realm.id
  name                     = "email"
  identity_provider_alias  = keycloak_oidc_identity_provider.bitbucket_identity_provider.alias
  identity_provider_mapper = "hardcoded-user-session-attribute-idp-mapper"

  # extra_config with syncMode is required in Keycloak 10+
  extra_config = {
    "syncMode"        = "INHERIT"
    "attribute"       = "email"
    "attribute.value" = "email"
  }
}

resource "keycloak_custom_identity_provider_mapper" "oidc_group_mapper" {
  realm        = keycloak_realm.realm.id
  name                     = "groups"
  identity_provider_alias  = keycloak_oidc_identity_provider.bitbucket_identity_provider.alias
  identity_provider_mapper = "hardcoded-user-session-attribute-idp-mapper"

  # extra_config with syncMode is required in Keycloak 10+
  extra_config = {
    "syncMode"        = "INHERIT"
    "attribute"       = "department"
    "attribute.value" = "department"
  }
}