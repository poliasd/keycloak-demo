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

resource "keycloak_saml_client" "sonarqube_saml_client" {
  realm_id  = var.realm_id
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

resource "keycloak_saml_client_default_scopes" "client_default_scopes" {
  realm_id  = var.realm_id
  client_id = keycloak_saml_client.sonarqube_saml_client.id
  default_scopes = []
}

resource "keycloak_saml_user_property_protocol_mapper" "saml_user_name_mapper" {
  realm_id  = var.realm_id
  client_id = keycloak_saml_client.sonarqube_saml_client.id
  name      = "Name"

  user_property              = "Username"
  saml_attribute_name        = "name"
  saml_attribute_name_format = "Unspecified"
}

resource "keycloak_saml_user_property_protocol_mapper" "saml_user_login_mapper" {
  realm_id  = var.realm_id
  client_id = keycloak_saml_client.sonarqube_saml_client.id
  name      = "Login"

  user_property              = "Username"
  saml_attribute_name        = "login"
  saml_attribute_name_format = "Unspecified"
}

resource "keycloak_saml_user_property_protocol_mapper" "saml_user_email_mapper" {
  realm_id  = var.realm_id
  client_id = keycloak_saml_client.sonarqube_saml_client.id
  name      = "Email"

  user_property              = "Email"
  saml_attribute_name        = "email"
  saml_attribute_name_format = "Unspecified"
}

resource "keycloak_generic_client_protocol_mapper" "saml_groups_mapper" {
  realm_id        = var.realm_id
  client_id       = keycloak_saml_client.sonarqube_saml_client.id
  name            = "Groups"
  protocol        = "saml"
  protocol_mapper = "saml-group-membership-mapper"
  config = {
    "attribute.name"       = "groups"
  }
}

data "keycloak_realm_keys" "realm_RS256_key" {
  realm_id   = var.realm_id
  algorithms = ["RS256"]
  status     = ["ACTIVE"]
}