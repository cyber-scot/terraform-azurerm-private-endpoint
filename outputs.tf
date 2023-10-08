output "custom_dns_configs" {
  value = { for idx, endpoint in azurerm_private_endpoint.endpoint : idx => {
    fqdn         = try(endpoint.custom_dns_configs[0].fqdn, null),
    ip_addresses = try(endpoint.custom_dns_configs[0].ip_addresses, null)
  } }
  description = "The custom DNS configurations of the private endpoints."
}

output "endpoint_ids" {
  value       = { for idx, endpoint in azurerm_private_endpoint.endpoint : idx => endpoint.id }
  description = "The IDs of the Private Endpoints."
}

output "ip_configurations" {
  value = {
    for endpoint in azurerm_private_endpoint.endpoint : endpoint.private_endpoint_name => {
      name               = try(endpoint.ip_configuration[0].name, null)
      private_ip_address = try(endpoint.ip_configuration[0].private_ip_address, null)
      subresource_name   = try(endpoint.ip_configuration[0].subresource_name, null)
    } if length(endpoint.ip_configuration) > 0
  }
  description = "A map of IP configurations for each private endpoint, keyed by the private endpoint name."
}

output "network_interfaces" {
  value = { for idx, endpoint in azurerm_private_endpoint.endpoint : idx => {
    id   = try(endpoint.network_interface[0].id, null),
    name = try(endpoint.network_interface[0].name, null)
  } }
  description = "The network interfaces associated with the private endpoints."
}

output "private_dns_zone_configs" {
  value = {
    name                = try(azurerm_private_endpoint.endpoint.private_dns_zone_configs[0].name, null),
    id                  = try(azurerm_private_endpoint.endpoint.private_dns_zone_configs[0].id, null),
    private_dns_zone_id = try(azurerm_private_endpoint.endpoint.private_dns_zone_configs[0].private_dns_zone_id, null),
    record_sets         = try(azurerm_private_endpoint.endpoint.private_dns_zone_configs[0].record_sets, null)
  }
}

output "private_service_connections" {
  value = { for idx, endpoint in azurerm_private_endpoint.endpoint : idx => {
    private_ip_address = try(endpoint.private_service_connection[0].private_ip_address, null)
  } }
  description = "The private service connections of the private endpoints."
}

output "record_sets" {
  value = {
    name         = try(azurerm_private_endpoint.endpoint.private_dns_zone_configs[0].record_sets[0].name, null),
    type         = try(azurerm_private_endpoint.endpoint.private_dns_zone_configs[0].record_sets[0].type, null),
    fqdn         = try(azurerm_private_endpoint.endpoint.private_dns_zone_configs[0].record_sets[0].fqdn, null),
    ttl          = try(azurerm_private_endpoint.endpoint.private_dns_zone_configs[0].record_sets[0].ttl, null),
    ip_addresses = try(azurerm_private_endpoint.endpoint.private_dns_zone_configs[0].record_sets[0].ip_addresses, null)
  }
}
