output "saml_sonarqube_client_id" {
  description = "Sonarqube SAML Client ID"
  value       = keycloak_saml_client.sonarqube_saml_client.client_id
}