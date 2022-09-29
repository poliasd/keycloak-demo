output "realm" {
  value = keycloak_realm.realm.id
}

output "provider_certificate" {
  value = data.keycloak_realm_keys.realm_RS256_key.keys[0].certificate
}