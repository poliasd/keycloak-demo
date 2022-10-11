# Keycloak helm chart values for bitnami/keycloak for enabling and adding script

This are values for [bitnami/keycloak](https://artifacthub.io/packages/helm/bitnami/keycloak) helm chart which will:
- Enable the scripts in the keycloak instance
- Download a jar file containing the Javascript script to the providers directory in KEYCLOAK_HOME
- Runs ```kc.sh build``` to deploy the file

