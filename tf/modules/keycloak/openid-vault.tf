resource "keycloak_openid_client" "openid_client" {
  realm_id                            = keycloak_realm.realm.id
  client_id                           = "vault-openid-client"
  name                                = "vault-openid"
  enabled                             = true
  access_type                         = "CONFIDENTIAL"
  valid_redirect_uris                 = var.valid_redirect_uris_openid
  standard_flow_enabled               = true
  direct_access_grants_enabled        = true
  admin_url                           = var.vault_url
  web_origins                         = [var.vault_url]
  backchannel_logout_session_required = true
}

resource "keycloak_generic_client_protocol_mapper" "openid_username_mapper" {
  realm_id          = keycloak_realm.realm.id
  client_id         = keycloak_openid_client.openid_client.id
  name              = "username"
  protocol          = "openid-connect"
  protocol_mapper   = "oidc-full-name-mapper"
  config = {
    "userinfo.token.claim" = "true",
    "user.attribute" = "username",
    "id.token.claim" = "true",
    "access.token.claim" = "true",
    "claim.name" = "preferred_username",
    "jsonType.label" = "String"
  }
}

resource "keycloak_generic_client_protocol_mapper" "openid_email_mapper" {
  realm_id          = keycloak_realm.realm.id
  client_id         = keycloak_openid_client.openid_client.id
  name              = "email"
  protocol          = "openid-connect"
  protocol_mapper   = "oidc-usermodel-property-mapper"
  config = {
    "userinfo.token.claim" = "true",
    "user.attribute" = "email",
    "id.token.claim" = "true",
    "access.token.claim" = "true",
    "claim.name" = "email",
    "jsonType.label" = "String"
  }
}

resource "keycloak_generic_client_protocol_mapper" "openid_full_name_mapper" {
  realm_id          = keycloak_realm.realm.id
  client_id         = keycloak_openid_client.openid_client.id
  name              = "full name"
  protocol          = "openid-connect"
  protocol_mapper   = "oidc-full-name-mapper"
  config = {
    "id.token.claim"       = "true",
    "access.token.claim"   = "true",
    "userinfo.token.claim" = "true"
  }
}

resource "keycloak_generic_client_protocol_mapper" "openid_group_mapper" {
  realm_id          = keycloak_realm.realm.id
  client_id         = keycloak_openid_client.openid_client.id
  name              = "groups"
  protocol          = "openid-connect"
  protocol_mapper   = "oidc-group-membership-mapper"
  config = {
    "full.path" = "false",
    "id.token.claim" = "true",
    "access.token.claim" = "true",
    "claim.name" = "groups",
    "userinfo.token.claim" = "true"
  }
}

output "openid_vault_client_id" {
  description = "Vault OpenID Client ID"
  value       =  keycloak_openid_client.openid_client.client_id
}

output "openid_vault_client_secret" {
  description = "Vault OpenID Client ID"
  value = keycloak_openid_client.openid_client.client_secret
}