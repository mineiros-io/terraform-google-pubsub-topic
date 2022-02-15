locals {
  iam_map = { for iam in var.iam : iam.role => iam }
}

module "topic-iam" {
  source = "github.com/mineiros-io/terraform-google-pubsub-topic-iam?ref=v0.0.3"

  for_each = var.policy_bindings == null ? local.iam_map : {}

  project = var.project

  topic         = try(google_pubsub_topic.topic[0].id, null)
  role          = each.value.role
  members       = each.value.members
  authoritative = try(each.value.authoritative, true)

  module_enabled    = var.module_enabled
  module_depends_on = [var.module_depends_on]
}

module "policy_bindings" {
  source = "github.com/mineiros-io/terraform-google-pubsub-topic-iam?ref=v0.0.3"

  count = var.policy_bindings != null ? 1 : 0

  module_enabled    = var.module_enabled
  module_depends_on = var.module_depends_on

  topic           = try(google_pubsub_topic.topic[0].id, null)
  policy_bindings = var.policy_bindings

  project = var.project
}
