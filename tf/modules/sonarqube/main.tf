terraform {
  required_providers {
    sonarqube = {
      source = "jdamata/sonarqube"
    }
  }
}

provider "sonarqube" {
    user   = var.user
    pass   = var.password
    host   = var.host
}

resource "sonarqube_setting" "setting_server_url" {
  key   = "sonar.core.serverBaseURL"
  value = var.host
}

resource "sonarqube_setting" "setting_saml" {
  key   = "sonar.auth.saml.enabled"
  value = true
}

resource "sonarqube_setting" "setting_auth_id" {
  key   = "sonar.auth.saml.applicationId"
  value = var.saml_sonarqube_client_id
}

resource "sonarqube_setting" "setting_provider_name" {
  key   = "sonar.auth.saml.providerName"
  value = "SAML"
}

resource "sonarqube_setting" "setting_auth_saml_providerId" {
  key   = "sonar.auth.saml.providerId"
  value = "${var.keycloak_host}/auth/realms/${var.realm}"
}

resource "sonarqube_setting" "setting_login_url" {
  key   = "sonar.auth.saml.loginUrl"
  value = "${var.keycloak_host}/auth/realms/${var.realm}/protocol/saml"
}

output "certificate" {
  value = var.provider_certificate
}

resource "sonarqube_setting" "setting_user_login_attribute" {
  key   = "sonar.auth.saml.user.login"
  value = "login"
}

resource "sonarqube_setting" "setting_user_email_attribute" {
  key   = "sonar.auth.saml.user.email"
  value = "email"
}

resource "sonarqube_setting" "setting_user_name" {
  key   = "sonar.auth.saml.user.name"
  value = "name"
}

resource "sonarqube_setting" "setting_groups" {
  key   = "sonar.auth.saml.group.name"
  value = "groups"
}

resource "sonarqube_group" "project_users" {
    name        = var.default_group
    description = "Default group"
}

resource "sonarqube_permissions" "my_global_admins" {
    group_name  = var.default_group
    permissions = ["admin"]
}