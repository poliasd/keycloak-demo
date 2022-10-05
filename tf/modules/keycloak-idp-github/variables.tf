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

variable "github_client_id" {
  description = "github OAuth client_id"
  type        = string
}

variable "github_client_secret" {
  description = "github OAuth client_secret"
  type        = string
}

variable "realm_id" {
  description = "Realm id"
  type = string
}