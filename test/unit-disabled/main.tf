# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# EMPTY FEATURES (DISABLED) UNIT TEST
# This module tests an empty set of features.
# The purpose is to verify no resources are created when the module is disabled.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# DO NOT RENAME MODULE NAME
module "test" {
  source = "../.."

  module_enabled = false

  name    = "test-name"
  project = "terraform-service-catalog"

  iam = [
    {
      role    = "roles/editor"
      members = ["allUsers"]
    }
  ]
}

module "testA" {
  source = "../.."

  module_enabled = false

  name    = "test-name"
  project = "terraform-service-catalog"

  policy_bindings = [
    {
      role    = "roles/editor"
      members = ["allUsers"]
    }
  ]
}

module "testB" {
  source = "../.."

  module_enabled = false

  name    = "test-name"
  project = "terraform-service-catalog"

  subscriptions = [
    {
      name    = "test-name"
      project = "terraform-service-catalog"
      topic   = "test-topic"
    }
  ]
}
