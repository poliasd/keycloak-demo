module "keycloak-realm" {
  source                      = "./modules/keycloak-realm"
  keycloak_url                = var.keycloak_url
  keycloak_client_id          = "admin-cli"
  keycloak_username           = var.keycloak_user
  keycloak_password           = var.keycloak_pass
  keycloak_realm              = "kcd-mena"
  display_name                = "KCD Mena"
  bitbucket_client_id         = var.bitbucket_client_id
  bitbucket_client_secret     = var.bitbucket_client_secret
  default_group               = var.default_group
}

module "keycloak-idp-bitbucket" {
  source                      = "./modules/keycloak-idp-bitbucket"
  keycloak_client_id          = "admin-cli"
  keycloak_username           = var.keycloak_user
  keycloak_password           = var.keycloak_pass
  keycloak_url                = var.keycloak_url
  bitbucket_client_id         = var.bitbucket_client_id
  bitbucket_client_secret     = var.bitbucket_client_secret
  realm_id                    = module.keycloak-realm.realm
}

module "keycloak-saml-sonarqube" {
  source = "./modules/keycloak-saml-sonarqube"
  keycloak_client_id          = "admin-cli"
  keycloak_username           = var.keycloak_user
  keycloak_password           = var.keycloak_pass
  keycloak_url                = var.keycloak_url
  realm_id                    = module.keycloak-realm.realm
  valid_redirect_uris_saml    = ["${var.sonarqube_url}/oauth2/callback/saml", "${var.sonarqube_url}/*", "*"]
}

module "sonarqube" {
  source                    = "./modules/sonarqube"
  user                      = var.sonarqube_user
  password                  = var.sonarqube_pass
  host                      = var.sonarqube_url
  keycloak_host             = var.keycloak_url
  saml_sonarqube_client_id  = module.keycloak-saml-sonarqube.saml_sonarqube_client_id
  provider_certificate      = module.keycloak-realm.provider_certificate
  default_group             = var.default_group
  realm_id                  = module.keycloak-realm.realm
}

module "keycloak-openid-vault" {
  source = "./modules/keycloak-openid-vault"
  keycloak_client_id          = "admin-cli"
  keycloak_username           = var.keycloak_user
  keycloak_password           = var.keycloak_pass
  keycloak_url                = var.keycloak_url
  realm_id                    = module.keycloak-realm.realm
  valid_redirect_uris_openid  = ["${var.vault_url}", "${var.vault_url}/*"]
  vault_url                   = var.vault_url
}

module "vault" {
  source        = "./modules/vault"
  keycloak_host = var.keycloak_url
  vault_url     = var.vault_url
  vault_token   = var.vault_token
  client_id     = module.keycloak-openid-vault.openid_vault_client_id
  client_secret = module.keycloak-openid-vault.openid_vault_client_secret
  realm_id      = module.keycloak-realm.realm
}