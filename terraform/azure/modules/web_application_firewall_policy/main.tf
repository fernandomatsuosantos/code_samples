resource "azurerm_web_application_firewall_policy" "web_application_firewall_policy" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  custom_rules {
    name      = "${var.name}-rule-1"
    priority  = 1
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }

      operator           = "GeoMatch"
      negation_condition = true
      match_values       = ["US", "BR"]
    }

    action = "Block"
  }

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.0"
      rule_group_override {
        rule_group_name = "REQUEST-931-APPLICATION-ATTACK-RFI"
        disabled_rules  = [931130]
      }
    }
  }

}