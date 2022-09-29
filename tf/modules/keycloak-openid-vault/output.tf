output "openid_vault_client_id" {
  description = "Vault OpenID Client ID"
  value       =  keycloak_openid_client.openid_client.client_id
}

output "openid_vault_client_secret" {
  description = "Vault OpenID Client ID"
  value = keycloak_openid_client.openid_client.client_secret
}