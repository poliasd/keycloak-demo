module "keycloak" {
  source                      = "./modules/keycloak"
  keycloak_client_id          = "admin-cli"
  keycloak_username           = var.keycloak_user
  keycloak_password           = var.keycloak_pass
  keycloak_url                = var.keycloak_url
  keycloak_realm              = "kcd-mena"
  display_name                = "KCD Mena"
  bitbucket_client_id         = var.bitbucket_client_id
  bitbucket_client_secret     = var.bitbucket_client_secret
  valid_redirect_uris_saml    = ["${var.sonarqube_url}/oauth2/callback/saml", "${var.sonarqube_url}/*", "*"]
  default_group               = var.default_group
  valid_redirect_uris_openid  = ["${var.vault_url}", "${var.vault_url}/*"]
  vault_url                   = var.vault_url
}

module "sonarqube" {
  source                    = "./modules/sonarqube"
  user                      = var.sonarqube_user
  password                  = var.sonarqube_pass
  host                      = var.sonarqube_url
  keycloak_host             = var.keycloak_url
  saml_sonarqube_client_id  = module.keycloak.saml_sonarqube_client_id
  provider_certificate      = module.keycloak.provider_certificate
  default_group             = var.default_group
  realm                     = module.keycloak.realm
}

module "vault" {
  source        = "./modules/vault"
  keycloak_host = var.keycloak_url
  vault_url     = var.vault_url
  vault_token   = var.vault_token
  client_id     = module.keycloak.openid_vault_client_id
  client_secret = module.keycloak.openid_vault_client_secret
  realm         = module.keycloak.realm
}


#provider "keycloak" {
#  client_id     = "admin-cli"
#  username      = "admin"
#  password      = "demo"
#  url           = "http://a234d6327f9f5457da40faafb151e9fa-100024433.eu-central-1.elb.amazonaws.com"
#  alias         = "config"
#}

#module "keycloak-realm" {
#  source              = "./modules/keycloak-realm"
##  keycloak_client_id  = "admin-cli"
##  keycloak_username   = "admin"
##  keycloak_password   = "demo"
##  keycloak_url        = "http://aa4f278cf96844145aa9d442743d6a75-1070552605.eu-central-1.elb.amazonaws.com"
#  keycloak_realm      = "kcd-mena"
#  realm_display_name  = "KCD Mena"
#  providers = {
#    mrparker = keycloak.config
#  }
#}

#module "keycloak-idp" {
#  source                  = "./modules/keycloak-idp"
#  keycloak_realm_id       = module.keycloak-realm.kexycloak_realm_id
#  alias                   = "bitbucket"
#  authorization_url       = "https://bitbucket.org/"
#  token_url               = "https://bitbucket.org/site/oauth2/access_token"
#  provider_id             = "bitbucket"
#  bitbucket_client_id     = "VRrzktTxnS29uwgzS6"
#  bitbucket_client_secret = "Ukfv9pNuk4vrqrgSDTPDVcfMtrsZ97jy"
#}

#module "keycloak-saml" {
#  source                  = "./modules/keycloak-saml"
#  keycloak_realm_id       = module.keycloak-realm.keycloak_realm_id
#  valid_redirect_uris     = ["http://af3b2a84e0e674da497dcbd9b939b3c1-371314828.eu-central-1.elb.amazonaws.com/oauth2/callback/saml"]
#}
#
#module "sonarqube" {
#  source                    = "./modules/sonarqube"
#  user                      = "admin"
#  password                  = "sonarqube"
#  host                      = "http://af3b2a84e0e674da497dcbd9b939b3c1-371314828.eu-central-1.elb.amazonaws.com"
#  saml_sonarqube_client_id  = module.keycloak.saml_sonarqube_client_id
#  provider_certificate      = module.keycloak.provider_certificate
#}
#
#
#
#
#

#
