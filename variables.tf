variable "value" {
  description = "The value to check for changes."
  type        = any
}

variable "depends" {
  description = "An optional list of things to wait for before storing the new value in the state. Use this to ensure things complete successfully before storing the new value, so that if they fail then on re-apply this module will still show that the value has changed."
  type        = list(any)
  default     = []
}
