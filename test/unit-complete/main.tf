# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# COMPLETE FEATURES UNIT TEST
# This module tests a complete set of most/all non-exclusive features
# The purpose is to activate everything the module offers, but trying to keep execution time and costs minimal.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

variable "gcp_region" {
  type        = string
  description = "(Required) The gcp region in which all resources will be created."
}

variable "gcp_project" {
  type        = string
  description = "(Required) The ID of the project in which the resource belongs."
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  region  = var.gcp_region
  project = var.gcp_project
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
    }
  ]

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
    ]

    module_depends_on = ["nothing"]
  }

  # outputs generate non-idempotent terraform plans so we disable them for now unless we need them.
  # output "all" {
  #   description = "All outputs of the module."
  #   value       = module.test
  # }
