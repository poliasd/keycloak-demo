terraform {
  required_version = ">= 0.13"

  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 3.10.0"
    }
  }
}

provider "keycloak" {
  client_id     = var.keycloak_client_id
  username      = var.keycloak_username
  password      = var.keycloak_password
  url           = var.keycloak_url
}

resource "keycloak_realm" "realm" {
  realm             = var.keycloak_realm
  enabled           = true
  display_name      = var.display_name
  display_name_html = "<b>${var.display_name}</b>"
  login_theme = "keycloak"
  access_code_lifespan = "1h"
  ssl_required    = "none"

  internationalization {
    supported_locales = [
      "en"
    ]
    default_locale    = "en"
  }

  security_defenses {
    headers {
      x_frame_options                     = "SAMEORIGIN"
      content_security_policy             = "frame-src 'self'; frame-ancestors 'self'; object-src 'none';"
      content_security_policy_report_only = ""
      x_content_type_options              = "nosniff"
      x_robots_tag                        = "none"
      x_xss_protection                    = "1; mode=block"
      strict_transport_security           = "max-age=31536000; includeSubDomains"
    }
    brute_force_detection {
      permanent_lockout                 = false
      max_login_failures                = 30
      wait_increment_seconds            = 60
      quick_login_check_milli_seconds   = 1000
      minimum_quick_login_wait_seconds  = 60
      max_failure_wait_seconds          = 900
      failure_reset_time_seconds        = 43200
    }
  }
}

#Configure default groups
resource "keycloak_group" "group" {
  realm_id = keycloak_realm.realm.id
  name     = var.default_group
}

resource "keycloak_default_groups" "default" {
  realm_id  = keycloak_realm.realm.id
  group_ids = [
    keycloak_group.group.id
  ]
}

data "keycloak_realm_keys" "realm_RS256_key" {
  realm_id   = keycloak_realm.realm.id
  algorithms = ["RS256"]
  status     = ["ACTIVE"]
}

