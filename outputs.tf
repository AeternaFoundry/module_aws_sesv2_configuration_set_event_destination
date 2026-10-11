output "sesv2_configuration_set_event_destinations_id" {
  description = "Map of id values across all sesv2_configuration_set_event_destinations, keyed the same as var.sesv2_configuration_set_event_destinations"
  value       = { for k, v in aws_sesv2_configuration_set_event_destination.sesv2_configuration_set_event_destinations : k => v.id if v.id != null && length(v.id) > 0 }
}
output "sesv2_configuration_set_event_destinations_configuration_set_name" {
  description = "Map of configuration_set_name values across all sesv2_configuration_set_event_destinations, keyed the same as var.sesv2_configuration_set_event_destinations"
  value       = { for k, v in aws_sesv2_configuration_set_event_destination.sesv2_configuration_set_event_destinations : k => v.configuration_set_name if v.configuration_set_name != null && length(v.configuration_set_name) > 0 }
}
output "sesv2_configuration_set_event_destinations_event_destination" {
  description = "Map of event_destination values across all sesv2_configuration_set_event_destinations, keyed the same as var.sesv2_configuration_set_event_destinations"
  value       = { for k, v in aws_sesv2_configuration_set_event_destination.sesv2_configuration_set_event_destinations : k => one(v.event_destination) if v.event_destination != null && length(v.event_destination) > 0 }
}
output "sesv2_configuration_set_event_destinations_event_destination_name" {
  description = "Map of event_destination_name values across all sesv2_configuration_set_event_destinations, keyed the same as var.sesv2_configuration_set_event_destinations"
  value       = { for k, v in aws_sesv2_configuration_set_event_destination.sesv2_configuration_set_event_destinations : k => v.event_destination_name if v.event_destination_name != null && length(v.event_destination_name) > 0 }
}
output "sesv2_configuration_set_event_destinations_region" {
  description = "Map of region values across all sesv2_configuration_set_event_destinations, keyed the same as var.sesv2_configuration_set_event_destinations"
  value       = { for k, v in aws_sesv2_configuration_set_event_destination.sesv2_configuration_set_event_destinations : k => v.region if v.region != null && length(v.region) > 0 }
}

