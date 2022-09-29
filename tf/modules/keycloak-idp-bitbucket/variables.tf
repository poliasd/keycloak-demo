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

variable "bitbucket_client_id" {
  description = "bitbucket OAuth client_id"
  type        = string
}

variable "bitbucket_client_secret" {
  description = "bitbucket OAuth client_secret"
  type        = string
}

variable "realm_id" {
  description = "Realm id"
  type = string
}