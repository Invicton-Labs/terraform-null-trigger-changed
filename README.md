# Terraform Values Changed

This module checks to see if a given input value has changed from the value that was provided for the last apply.

## Usage

### Run 1

```
module "value-changed" {
  source = "Invicton-Labs/value-changed/null"
  value  = "original value"
}

output "value-changed" {
  value = module.value-changed
}
```

Note that the `changed` output parameter is `true` since it's being stored for the first time.
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

value-changed = {
  "changed" = true
  "new_value" = "original value"
  "old_value" = null
}
```

### Run 2 (do not change the input value)
```
module "value-changed" {
  source = "Invicton-Labs/value-changed/null"
  value  = "original value"
}

output "value-changed" {
  value = module.value-changed
}
```

Note that the `changed` output parameter is `false`, since the input value didn't change.
```
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

value-changed = {
  "changed" = false
  "new_value" = "original value"
  "old_value" = "original value"
}
```

### Run 3 (change the input value)
```
module "value-changed" {
  source = "Invicton-Labs/value-changed/null"
  value  = "new value"
}

output "value-changed" {
  value = module.value-changed
}
```

Note that the `changed` output parameter is `false`, since the input value didn't change.
```
Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

Outputs:

value-changed = {
  "changed" = true
  "new_value" = "new value"
  "old_value" = "original value"
}
```