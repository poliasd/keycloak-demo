AuthenticationFlowError = Java.type("org.keycloak.authentication.AuthenticationFlowError");

function authenticate(context) {
    LOG.info("#####################################################################################");
    LOG.info("Script name="+script.getName()+"; description="+script.getDescription()+"; realmId="+script.getRealmId());
    LOG.info(script.name + " --> trace auth for: " + user.username + ", email: " + user.email );

    var userEmail = user.email;
    var attributes = authenticationSession.getUserSessionNotes()
    var emailDomain = attributes.get("emailDomain");
    LOG.info("ATTRIBUTES: " + attributes);
    LOG.info("ATTRIBUTE DOMAIN EMAIL: " + emailDomain);

    if ( !userEmail.contains(emailDomain) ) {
        context.failure(AuthenticationFlowError.INVALID_USER);
        LOG.error("User " + user.username + "with email " + userEmail + " is not allowed to login.");
        return;
    }

    context.success();
}