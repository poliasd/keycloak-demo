# Keycloak used as identity broker 
This repository contains terraform scripts for configuring:
* Keycloak as an Identity broker 
* Bitbucket as an Identity provider
* Sonarqube as a client using SAML protocol
* Vault as a client using OpenID Connect protocol

![Keycloak as an Identity broker](keycloak-identity-broker.jpeg)

### Prerequisites
#### Adding Keycloak as an OAuth consumer in Bitbucket 
Adding Keycloak as an [OAuth consumer in Bitbucket](https://support.atlassian.com/bitbucket-cloud/docs/integrate-another-application-through-oauth/). 

1. Navigate to https://bitbucket.org/.
2. Choose a workspace -> Settings -> OAuth consumers
3. Enter name
4. As a callback URL enter: *{keycloak url}/auth/realms/{realm name}/broker/bitbucket/endpoint*
5. Set read account permissions

After you press the save button, you will see Key and Secret. The key and secret have to be set as values to variables: **bitbucket_client_id** and **bitbucket_client_secret**.  

#### Adding Keycloak as an OAuth app in GitHub
Adding Keycloak as an [OAuth App](https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app)

1. Navigate to https://github.com/
2. Choose Your organzations from the upper-right corner
3. Click Settings next to the organzation name
4. Scroll down and expand Developer settings
5. Select OAuth Apps
6. Click New OAuth App
7. Enter Application name
8. In "Homepage URL", type the full URL to your app's website
9. In "Authorization callback URL", type the callback URL of your app: {keycloak url}/auth/realms/{realm name}/broker/github/endpoint

After you click on Register application you will see a Cliend ID. This is the value of **github_client_id**.
Generate a new Client secrets and set it as value to **github_client_secret**.

Add values to the following variables defined in [tf/variables.tf](tf/variables.tf):
* keycloak_url
* keycloak_user
* keycloak_password
* keycloak_url
* keycloak_realm
* display_name
* default_group
* bitbucket_client_id
* bitbucket_client_secret
* github_client_id
* github_client_secret

### Terraform modules

#### [keycloak-realm](tf/keycloak-realm)
Creates Keycloak realm\
**Documentation**: https://www.keycloak.org/docs/latest/server_admin/#proc-creating-a-realm_server_administration_guide

#### [keycloak-idp-bitbucket](tf/keycloak-idp-bitbucket)
Adds Bitbucket as an Identity provider\
**Documentation**: https://www.keycloak.org/docs/latest/server_admin/#bitbucket

#### [keycloak-idp-bitbucket](tf/keycloak-idp-github)
Adds GitHub as an Identity provider\
**Documentation**: https://www.keycloak.org/docs/latest/server_admin/#_github

#### [keycloak-idp-bitbucket](tf/keycloak-idp-bitbucket) 
Adds Sonarqube as a client using SAML protocol\
**Documentation**: https://docs.sonarqube.org/latest/instance-administration/delegated-auth/

#### [sonarqube](tf/sonarqube)
Adding SAML authentication in Sonarqube (sonar.auth.saml.certificate.secured has to be manually added, it is not supported by the Terraform module)\
**Documentation**: https://docs.sonarqube.org/latest/instance-administration/delegated-auth/

#### [keycloak-openid-vault](tf/keycloak-openid-vault)
Adds Vault as a client using OpenID Connect protocol\
**Documentation**: https://www.vaultproject.io/docs/auth/jwt/oidc-providers/keycloak

#### [vault](tf/vault)
Adds OpenID Connect authentication in Vault

### Running terraform 
After you have successfully added Keycloak as an OAuth consumer and you have added the variables run:
```shell
cd tf
terraform apply
```