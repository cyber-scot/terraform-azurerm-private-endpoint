output "custom_dns_configs" {
  value = { for idx, endpoint in azurerm_private_endpoint.endpoint : idx => {
    fqdn         = endpoint.custom_dns_configs[0].fqdn,
    ip_addresses = endpoint.custom_dns_configs[0].ip_addresses
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
    id   = endpoint.network_interface[0].id,
    name = endpoint.network_interface[0].name
  } }
  description = "The network interfaces associated with the private endpoints."
}

output "private_dns_zone_configs" {
  value = {
    name                = try(values(endpoint.private_dns_zone_configs)[0].name, null),
    id                  = try(values(endpoint.private_dns_zone_configs)[0].id, null),
    private_dns_zone_id = try(values(endpoint.private_dns_zone_configs)[0].private_dns_zone_id, null),
    record_sets         = try(values(endpoint.private_dns_zone_configs)[0].record_sets, null)
  }
}

output "private_service_connections" {
  value = { for idx, endpoint in azurerm_private_endpoint.endpoint : idx => {
    private_ip_address = endpoint.private_service_connection[0].private_ip_address
  } }
  description = "The private service connections of the private endpoints."
}

output "record_sets" {
  value = {
    name         = try(values(endpoint.private_dns_zone_configs)[0].record_sets[0].name, null),
    type         = try(values(endpoint.private_dns_zone_configs)[0].record_sets[0].type, null),
    fqdn         = try(values(endpoint.private_dns_zone_configs)[0].record_sets[0].fqdn, null),
    ttl          = try(values(endpoint.private_dns_zone_configs)[0].record_sets[0].ttl, null),
    ip_addresses = try(values(endpoint.private_dns_zone_configs)[0].record_sets[0].ip_addresses, null)
  }
}
