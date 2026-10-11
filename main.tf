resource "aws_sesv2_configuration_set_event_destination" "sesv2_configuration_set_event_destinations" {
  for_each = var.sesv2_configuration_set_event_destinations

  configuration_set_name = each.value.configuration_set_name
  event_destination_name = each.value.event_destination_name
  region                 = each.value.region

  event_destination {
    dynamic "cloud_watch_destination" {
      for_each = each.value.event_destination.cloud_watch_destination != null ? [each.value.event_destination.cloud_watch_destination] : []
      content {
        dynamic "dimension_configuration" {
          for_each = cloud_watch_destination.value.dimension_configuration
          content {
            default_dimension_value = dimension_configuration.value.default_dimension_value
            dimension_name          = dimension_configuration.value.dimension_name
            dimension_value_source  = dimension_configuration.value.dimension_value_source
          }
        }
      }
    }
    enabled = each.value.event_destination.enabled
    dynamic "event_bridge_destination" {
      for_each = each.value.event_destination.event_bridge_destination != null ? [each.value.event_destination.event_bridge_destination] : []
      content {
        event_bus_arn = event_bridge_destination.value.event_bus_arn
      }
    }
    dynamic "kinesis_firehose_destination" {
      for_each = each.value.event_destination.kinesis_firehose_destination != null ? [each.value.event_destination.kinesis_firehose_destination] : []
      content {
        delivery_stream_arn = kinesis_firehose_destination.value.delivery_stream_arn
        iam_role_arn        = kinesis_firehose_destination.value.iam_role_arn
      }
    }
    matching_event_types = each.value.event_destination.matching_event_types
    dynamic "pinpoint_destination" {
      for_each = each.value.event_destination.pinpoint_destination != null ? [each.value.event_destination.pinpoint_destination] : []
      content {
        application_arn = pinpoint_destination.value.application_arn
      }
    }
    dynamic "sns_destination" {
      for_each = each.value.event_destination.sns_destination != null ? [each.value.event_destination.sns_destination] : []
      content {
        topic_arn = sns_destination.value.topic_arn
      }
    }
  }
}

