locals {
  # filter all objects that define a single role
  iam_role = [for iam in var.iam : iam if can(iam.role)]

  # filter all objects that define multiple roles and expand them to single roles
  iam_roles = flatten([for iam in var.iam :
    [for role in iam.roles : merge(iam, { role = role })] if can(iam.roles)
  ])

  # we allow to define role and roles in the same object and concatenate them
  # each role can only be specified exactly once
  iam = concat(local.iam_role, local.iam_roles)

  iam_map = { for idx, iam in local.iam :
    try(iam._key, iam.role) => idx
  }
}

module "iam" {
  source = "github.com/mineiros-io/terraform-google-pubsub-topic-iam?ref=v0.0.5"

  for_each = var.policy_bindings == null ? local.iam_map : {}

  project = var.project

  topic                = try(google_pubsub_topic.topic[0].id, null)
  role                 = local.iam[each.value].role
  members              = local.iam[each.value].members
  computed_members_map = var.computed_members_map
  authoritative        = try(local.iam[each.value].authoritative, true)

  module_enabled    = var.module_enabled
  module_depends_on = [var.module_depends_on]
}

module "policy_bindings" {
  source = "github.com/mineiros-io/terraform-google-pubsub-topic-iam?ref=v0.0.5"

  count = var.policy_bindings != null ? 1 : 0

  module_enabled    = var.module_enabled
  module_depends_on = var.module_depends_on

  topic                = try(google_pubsub_topic.topic[0].id, null)
  policy_bindings      = var.policy_bindings
  computed_members_map = var.computed_members_map

  project = var.project
}
