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

variable "realm_id" {
  description = "Realm id"
  type = string
}

variable "valid_redirect_uris_saml" {
  description = "Valid Redirect SAML URIs"
  type        = list(string)
}