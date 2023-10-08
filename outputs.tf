output "endpoint_ids" {
  value = { for idx, endpoint in azurerm_private_endpoint.endpoint : idx => endpoint.id }
  description = "The IDs of the Private Endpoints."
}

output "network_interfaces" {
  value = { for idx, endpoint in azurerm_private_endpoint.endpoint : idx => {
    id   = endpoint.network_interface[0].id,
    name = endpoint.network_interface[0].name
  }}
  description = "The network interfaces associated with the private endpoints."
}

output "custom_dns_configs" {
  value = { for idx, endpoint in azurerm_private_endpoint.endpoint : idx => {
    fqdn         = endpoint.custom_dns_configs[0].fqdn,
    ip_addresses = endpoint.custom_dns_configs[0].ip_addresses
  }}
  description = "The custom DNS configurations of the private endpoints."
}

output "private_dns_zone_configs" {
  value = { for idx, endpoint in azurerm_private_endpoint.endpoint : idx => {
    name              = endpoint.private_dns_zone_configs[0].name,
    id                = endpoint.private_dns_zone_configs[0].id,
    private_dns_zone_id = endpoint.private_dns_zone_configs[0].private_dns_zone_id,
    record_sets       = endpoint.private_dns_zone_configs[0].record_sets
  }}
  description = "The private DNS zone configurations of the private endpoints."
}

output "ip_configurations" {
  value = {
    for endpoint in azurerm_private_endpoint.endpoint : endpoint.private_endpoint_name => {
      name              = try(endpoint.ip_configuration[0].name, null)
      private_ip_address = try(endpoint.ip_configuration[0].private_ip_address, null)
      subresource_name   = try(endpoint.ip_configuration[0].subresource_name, null)
    } if length(endpoint.ip_configuration) > 0
  }
  description = "A map of IP configurations for each private endpoint, keyed by the private endpoint name."
}

output "private_service_connections" {
  value = { for idx, endpoint in azurerm_private_endpoint.endpoint : idx => {
    private_ip_address = endpoint.private_service_connection[0].private_ip_address
  }}
  description = "The private service connections of the private endpoints."
}

output "record_sets" {
  value = { for idx, endpoint in azurerm_private_endpoint.endpoint : idx => {
    name        = endpoint.private_dns_zone_configs[0].record_sets[0].name,
    type        = endpoint.private_dns_zone_configs[0].record_sets[0].type,
    fqdn        = endpoint.private_dns_zone_configs[0].record_sets[0].fqdn,
    ttl         = endpoint.private_dns_zone_configs[0].record_sets[0].ttl,
    ip_addresses = endpoint.private_dns_zone_configs[0].record_sets[0].ip_addresses
  }}
  description = "The record sets of the private endpoints."
}
