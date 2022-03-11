resource "google_pubsub_topic" "topic" {
  count = var.module_enabled ? 1 : 0

  project = var.project
  name    = var.name

  labels = var.labels

  kms_key_name = var.kms_key_name

  message_retention_duration = var.message_retention_duration

  dynamic "message_storage_policy" {
    for_each = var.allowed_persistence_regions != null ? [1] : []

    content {
      allowed_persistence_regions = var.allowed_persistence_regions
    }
  }

  dynamic "schema_settings" {
    for_each = try([var.schema.name], [])

    content {
      schema   = try(google_pubsub_schema.schema[var.schema.name].id, null)
      encoding = try(var.schema.encoding, "ENCODING_UNSPECIFIED")
    }
  }

  depends_on = [var.module_depends_on]
}

resource "google_pubsub_schema" "schema" {
  for_each = can(var.schema.name) ? { var.schema.name = var.schema } : {}

  project = var.project

  name       = each.key
  type       = try(each.value.type, null)
  definition = try(each.value.definition, null)
}
