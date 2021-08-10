output "changed" {
  description = "Whether the `value` input parameter has changed since the last apply."
  value       = local.triggers_modified
}

output "old_value" {
  description = "The value from the last apply."
  value       = local.existing_trigger_json != null ? jsondecode(local.existing_trigger_json) : null
}

output "new_value" {
  description = "The new value."
  value       = var.value
}
