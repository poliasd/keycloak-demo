variable "keycloak_client_id" {
  description = "Keycloak client id"
  type        = string
}

variable "keycloak_username" {
  description = "Keycloak username"
  type        = string
}

variable "keycloak_password" {
  description = "Keycloak password"
  type        = string
}

variable "keycloak_url" {
  description = "Keycloak url"
  type        = string
}

variable "keycloak_realm" {
  description = "Keycloak realm name"
  type        = string
}

variable "display_name" {
  description = "Keycloak display name"
  type        = string
}

variable "bitbucket_client_id" {
  description = "bitbucket OAuth client_id"
  type        = string
}

variable "bitbucket_client_secret" {
  description = "bitbucket OAuth client_secret"
  type        = string
}

variable "valid_redirect_uris_saml" {
  description = "Valid Redirect SAML URIs"
  type        = list(string)
}

variable "valid_redirect_uris_openid" {
  description = "Valid Redirect OPENID URIs"
  type        = list(string)
}

variable "default_group" {
  description = "Default group"
  type        = string
}

variable "vault_url" {
  description = "Vault url"
  type        = string
}