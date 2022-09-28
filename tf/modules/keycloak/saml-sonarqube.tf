# Configuring SAML

resource "keycloak_saml_client" "sonarqube_saml_client" {
  realm_id  = keycloak_realm.realm.id
  client_id = "sonarqube_saml_client"
  name      = "sonarqube-saml"

  sign_documents            = true
  sign_assertions           = false
  include_authn_statement   = true
  force_post_binding        = true
  front_channel_logout      = true
  name_id_format            = "username"
  valid_redirect_uris       = var.valid_redirect_uris_saml
  signature_algorithm       = "RSA_SHA256"
  client_signature_required = false
}

resource "keycloak_saml_user_property_protocol_mapper" "saml_user_name_mapper" {
  realm_id  = keycloak_realm.realm.id
  client_id = keycloak_saml_client.sonarqube_saml_client.id
  name      = "Name"

  user_property              = "Username"
  saml_attribute_name        = "name"
  saml_attribute_name_format = "Unspecified"
}

resource "keycloak_saml_user_property_protocol_mapper" "saml_user_login_mapper" {
  realm_id  = keycloak_realm.realm.id
  client_id = keycloak_saml_client.sonarqube_saml_client.id
  name      = "Login"

  user_property              = "Username"
  saml_attribute_name        = "login"
  saml_attribute_name_format = "Unspecified"
}

resource "keycloak_saml_user_property_protocol_mapper" "saml_user_email_mapper" {
  realm_id  = keycloak_realm.realm.id
  client_id = keycloak_saml_client.sonarqube_saml_client.id
  name      = "Email"

  user_property              = "Email"
  saml_attribute_name        = "email"
  saml_attribute_name_format = "Unspecified"
}

resource "keycloak_generic_client_protocol_mapper" "saml_groups_mapper" {
  realm_id        = keycloak_realm.realm.id
  client_id       = keycloak_saml_client.sonarqube_saml_client.id
  name            = "Groups"
  protocol        = "saml"
  protocol_mapper = "saml-group-membership-mapper"
  config = {
    "attribute.name"       = "groups"
  }
}

data "keycloak_realm_keys" "realm_RS256_key" {
  realm_id   = keycloak_realm.realm.id
  algorithms = ["RS256"]
  status     = ["ACTIVE"]
}

output "saml_sonarqube_client_id" {
  description = "Sonarqube SAML Client ID"
  value       = keycloak_saml_client.sonarqube_saml_client.client_id
}