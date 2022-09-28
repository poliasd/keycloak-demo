variable "vault_url" {
  description = "Vault url"
  type        = string
}

variable "vault_token" {
  description = "Vault token"
  type        = string
}


variable "client_secret" {
  description = "Required: OIDC Client secret for Hashicorp Vault"
  type        = string
}

variable "client_id" {
  description = "Required: OIDC Client ID for Hashicorp Vault"
  default     = "vault-openid"
}

variable "keycloak_host" {
  description = "Keycloak host"
  type        = string
}

variable "realm" {
  description = "Realm id"
  type = string
}