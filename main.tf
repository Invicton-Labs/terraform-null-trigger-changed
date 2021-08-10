// Get the existing state
module "state" {
  source  = "Invicton-Labs/get-state/null"
  version = "0.2.1"
}

locals {
  trigger_json = jsonencode(var.value)
}

// A unique ID for this module
resource "random_uuid" "module_id" {}

// Track the last set of triggers
resource "null_resource" "keeper" {
  triggers = {
    "___CONDITIONAL_TRIGGER_module_id" = random_uuid.module_id.id
    trigger                            = local.trigger_json
    // This is a way to force the re-create to wait until other (optional) resources or data sources have finished
    depends = var.depends == null ? "" : ""
  }
  lifecycle {
    create_before_destroy = true
  }
}

locals {
  existing_resources = [
    for address, resource in module.state.resources :
    resource
    if resource.type == "null_resource" && resource.name == "keeper" ? lookup(resource.instances[0].attributes.triggers, "___CONDITIONAL_TRIGGER_module_id", null) == random_uuid.module_id.id : false
  ]
  existing_trigger_json = length(local.existing_resources) > 0 ? local.existing_resources[0].instances[0].attributes.triggers.trigger : null
  triggers_modified     = local.existing_trigger_json != local.trigger_json
}
