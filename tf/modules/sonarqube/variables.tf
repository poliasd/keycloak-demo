variable "user" {
  description = "Sonarqube user"
  type        = string
}

variable "password" {
  description = "Sonarqube password"
  type        = string
}

variable "host" {
  description = "Sonarqube Hostname"
  type        = string
}

variable "saml_sonarqube_client_id" {
  description = "Sonarqube SAML Client ID"
  type        = string
}

variable "provider_certificate" {
  description = "SAML Provider"
  type        = string
}

variable "keycloak_host" {
  description = "Keycloak host"
  type        = string
}

variable "default_group" {
  description = "Default group"
  type        = string
}

variable "realm" {
  description = "Realm id"
  type = string
}