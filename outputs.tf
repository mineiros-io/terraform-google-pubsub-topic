# ----------------------------------------------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ----------------------------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ----------------------------------------------------------------------------------------------------------------------

output "topic" {
  value       = try(google_pubsub_topic.topic[0], {})
  description = "The created pub sub resource."
}

output "iam" {
  description = "The iam resource objects that define access to the GCS bucket."
  value       = module.iam
}

output "subscription" {
  description = "All attributes of the created subscriptions."
  value       = module.subscription
}

# ----------------------------------------------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ----------------------------------------------------------------------------------------------------------------------

output "module_enabled" {
  description = "Whether or not the module is enabled."
  value       = var.module_enabled
}
