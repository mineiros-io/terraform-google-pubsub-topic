resource "google_pubsub_topic" "topic" {
  count = var.module_enabled ? 1 : 0

  project = var.project
  name    = var.name

  labels = var.labels

  kms_key_name = var.kms_key_name

  dynamic "message_storage_policy" {
    for_each = var.allowed_persistence_regions != null ? [1] : []

    content {
      allowed_persistence_regions = var.allowed_persistence_regions
    }
  }

  depends_on = [var.module_depends_on]
}
