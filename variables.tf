variable "sesv2_configuration_set_event_destinations" {
  description = <<EOT
Map of sesv2_configuration_set_event_destinations, attributes below
Required:
    - configuration_set_name
    - event_destination_name
    - event_destination (block):
        - cloud_watch_destination (optional, block):
            - dimension_configuration (required, block):
                - default_dimension_value (required)
                - dimension_name (required)
                - dimension_value_source (required)
        - enabled (optional)
        - event_bridge_destination (optional, block):
            - event_bus_arn (required)
        - kinesis_firehose_destination (optional, block):
            - delivery_stream_arn (required)
            - iam_role_arn (required)
        - matching_event_types (required)
        - pinpoint_destination (optional, block):
            - application_arn (required)
        - sns_destination (optional, block):
            - topic_arn (required)
Optional:
    - region
EOT

  type = map(object({
    configuration_set_name = string
    event_destination_name = string
    region                 = optional(string)
    event_destination = object({
      cloud_watch_destination = optional(object({
        dimension_configuration = list(object({
          default_dimension_value = string
          dimension_name          = string
          dimension_value_source  = string
        }))
      }))
      enabled = optional(bool)
      event_bridge_destination = optional(object({
        event_bus_arn = string
      }))
      kinesis_firehose_destination = optional(object({
        delivery_stream_arn = string
        iam_role_arn        = string
      }))
      matching_event_types = set(string)
      pinpoint_destination = optional(object({
        application_arn = string
      }))
      sns_destination = optional(object({
        topic_arn = string
      }))
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.sesv2_configuration_set_event_destinations : (
        v.event_destination.cloud_watch_destination == null || (length(v.event_destination.cloud_watch_destination.dimension_configuration) >= 1)
      )
    ])
    error_message = "Each dimension_configuration list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.sesv2_configuration_set_event_destinations : (
        v.event_destination.cloud_watch_destination == null || (alltrue([for item in v.event_destination.cloud_watch_destination.dimension_configuration : (length(item.default_dimension_value) >= 1 && length(item.default_dimension_value) <= 256)]))
      )
    ])
    error_message = "must be between 1 and 256 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sesv2_configuration_set_event_destinations : (
        v.event_destination.cloud_watch_destination == null || (alltrue([for item in v.event_destination.cloud_watch_destination.dimension_configuration : (length(item.dimension_name) >= 1 && length(item.dimension_name) <= 256)]))
      )
    ])
    error_message = "must be between 1 and 256 characters"
  }
  # Note: 7 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

