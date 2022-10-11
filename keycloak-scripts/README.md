# A Javascript provider script for checking the domain of the email

Social identity providers (GitHub, Bitbucket, GitLab ...) are not filtered by organization. What it means is that everyone which has an account in the listed providers will be able to login to the keycloak instance. 

Keycloak has the ability to execute scripts during runtime in order to allow administrators to customize [specific functionalities](https://www.keycloak.org/docs/latest/server_development/#_script_providers). 

This script will check if the user's email is within a specified domain, if it is the user will be allowed to login otherwise a message for an invalid user will be shown.

###Using the script
### Prerequisites
Enable scripts in Keycloak by setting:
```shell
-Dkeycloak.profile.feature.scripts=enabled
```

1. Package the script
```shell
jar cfv email-domain-check.jar
```
2. Copy the jar file into __${KEYCLOAK_HOME}/providers/__
3. Run the following command in keycloak:
```shell
${KEYCLOAK_HOME}/bin/kc.sh build
```
_Steps 2 and 3 are added in this [helm chart](../helm-chart-values). The email-domain-check.jar has to be deployed to a location visible from the helm chart._

4. In Keycloak console navigate to you **Realm -> Authentication**
5. Click on the button **Create flow**
6. Give it a name, example: **post login**
7. Click on the button **Create**
8. Add an execution
9. Find the step **Email domain Verifier Authenticator** and add it
10. On the next screen choose **Alternative** as a requirement

Now it is time to add the email domain in the identity provider

11. Navigate to the identity provider where this condition will be applied
12. Choose Mappers
13. As a name enter **emailDomain**
14. Mapper type should be **Hardcoded User Session Attribute**
15. Enter **emailDomain** in User Session Attribute 
16. In the field User Session Attribute Value enter the accepted email domain

17. Go to the settings of the idenity provider
18. In the Post login flow choose **post login**

You ready to use the new login condition.