variable "keycloak_url" {
  description = "Keycloak url"
  type        = string
}

variable "keycloak_user" {
  description = "Keycloak user"
  type        = string
}

variable "keycloak_pass" {
  description = "Keycloak password"
  type        = string
}

variable "sonarqube_url" {
  description = "Sonarqube url"
  type        = string
}

variable "sonarqube_user" {
  description = "Sonarqube username"
  type        = string
}

variable "sonarqube_pass" {
  description = "Sonarqube password"
  type        = string
  default     = "sonarqube"
}

variable "vault_url" {
  description = "Vault url"
  type        = string
}

variable "vault_token" {
  description = "Vault token"
  type        = string
}

variable "bitbucket_client_id" {
  description = "Bitbucket client ID"
  type        = string
}

variable "bitbucket_client_secret" {
  description = "Bitbucket client secret"
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

variable "gitlab_client_id" {
  description = "github OAuth client_id"
  type        = string
}

variable "gitlab_client_secret" {
  description = "github OAuth client_secret"
  type        = string
}

variable "default_group" {
  description = "Default group"
  type        = string
  default     = "kcd-mena"
}