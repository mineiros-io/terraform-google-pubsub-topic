# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# COMPLETE FEATURES UNIT TEST
# This module tests a complete set of most/all non-exclusive features
# The purpose is to activate everything the module offers, but trying to keep execution time and costs minimal.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

module "test-sa" {
  source = "github.com/mineiros-io/terraform-google-service-account?ref=v0.0.10"

  account_id = "service-account-id-${local.random_suffix}"
}

# DO NOT RENAME MODULE NAME
module "test" {
  source = "../.."

  module_enabled = true

  # add all required arguments
  name    = "test-name"
  project = "terraform-service-catalog"

  # add all optional arguments that create additional resources
  iam = [
    {
      role    = "roles/viewer"
      members = ["domain:mineiros.io"]
    },
    {
      role    = "roles/editor"
      members = ["computed:myserviceaccount"]
    },
    {
      roles   = ["roles/admin", "roles/owner"]
      members = ["group:engineers"]
    }
  ]

  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
  }

  # add most/all other optional arguments
  labels = {
    "test" = "test"
  }
  kms_key_name = "key-name"
  allowed_persistence_regions = [
    "us-west1",
  ]

  subscriptions = [
    {
      name    = "test-name"
      project = "terraform-service-catalog"
      topic   = "test-topic"

      labels = {
        "test" = "test"
      }

      ack_deadline_seconds       = 10
      message_retention_duration = "60s"
      retain_acked_messages      = false
      filter                     = "*"
      enable_message_ordering    = true
      expiration_policy_ttl      = "10s"

      retry_policy = {
        minimum_backoff = "10s"
        maximum_backoff = "60s"
      }

      iam = [
        {
          role    = "roles/viewer"
          members = ["domain:mineiros.io"]
        }
      ]
    }
  ]

  module_depends_on = ["nothing"]
}
