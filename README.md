
```hcl
resource "azurerm_private_endpoint" "endpoint" {
  for_each                          = { for v in var.private_endpoints : v.name => v }

  name                          = each.value.name
  location                      = each.value.location
  resource_group_name           = each.value.rg_name
  subnet_id                     = each.value.subnet_id
  custom_network_interface_name = each.value.custom_network_interface_name
  tags                          = each.value.tags

  dynamic "private_service_connection" {
    for_each = each.value.private_service_connection != null ? [each.value.private_service_connection] : []
    content {
      name                              = private_service_connection.value.name
      is_manual_connection              = private_service_connection.value.is_manual_connection
      private_connection_resource_id    = private_service_connection.value.private_connection_resource_id
      private_connection_resource_alias = private_service_connection.value.private_connection_resource_alias
      subresource_names                 = private_service_connection.value.subresource_names
      request_message                   = private_service_connection.value.is_manual_connection == true ? private_service_connection.value.request_message : null
    }
  }

  dynamic "private_dns_zone_group" {
    for_each = each.value.private_dns_zone_group != null ? [each.value.private_dns_zone_group] : []
    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
    }
  }

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration != null ? [each.value.ip_configuration] : []
    content {
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name = ip_configuration.value.subresource_name
      member_name        = ip_configuration.value.member_name
    }
  }
}
```
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | n/a | <pre>list(object({<br>    name                          = string<br>    location                      = string<br>    rg_name                       = string<br>    subnet_id                     = string<br>    custom_network_interface_name = optional(string)<br>    tags                          = optional(map(string))<br>    private_service_connection = optional(object({<br>      name                              = string<br>      is_manual_connection              = optional(bool)<br>      private_connection_resource_id    = optional(string)<br>      private_connection_resource_alias = optional(string)<br>      subresource_names                 = optional(list(string))<br>      request_message                   = optional(string)<br>    }))<br>    private_dns_zone_group = optional(object({<br>      name                 = string<br>      private_dns_zone_ids = optional(list(string))<br>    }))<br>    ip_configuration = optional(object({<br>      name               = string<br>      private_ip_address = optional(string)<br>      subresource_name   = optional(list(string))<br>      member_name        = optional(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_sub_resource_names"></a> [sub\_resource\_names](#input\_sub\_resource\_names) | The sub resource names of private endpoints found at https://learn.microsoft.com/en-gb/azure/private-link/private-endpoint-overview#private-link-resource, not used, but provided for lookup option | `map(string)` | <pre>{<br>  "Microsoft.Appconfiguration/configurationStores": "configurationStores",<br>  "Microsoft.Authorization/resourceManagementPrivateLinks": "ResourceManagement",<br>  "Microsoft.Automation/automationAccounts": "Webhook, DSCAndHybridWorker",<br>  "Microsoft.AzureCosmosDB/databaseAccounts": "SQL, MongoDB, Cassandra, Gremlin, Table",<br>  "Microsoft.Batch/batchAccounts": "batchAccount, nodeManagement",<br>  "Microsoft.Cache/Redis": "redisCache",<br>  "Microsoft.Cache/redisEnterprise": "redisEnterprise",<br>  "Microsoft.CognitiveServices/accounts": "account",<br>  "Microsoft.Compute/diskAccesses": "managed disk",<br>  "Microsoft.ContainerRegistry/registries": "registry",<br>  "Microsoft.ContainerService/managedClusters": "management",<br>  "Microsoft.DBforMariaDB/servers": "mariadbServer",<br>  "Microsoft.DBforMySQL/servers": "mysqlServer",<br>  "Microsoft.DBforPostgreSQL/servers": "postgresqlServer",<br>  "Microsoft.DataFactory/factories": "dataFactory",<br>  "Microsoft.Databricks/workspaces": "databricks_ui_api, browser_authentication",<br>  "Microsoft.Devices/IotHubs": "iotHub",<br>  "Microsoft.Devices/provisioningServices": "iotDps",<br>  "Microsoft.DigitalTwins/digitalTwinsInstances": "API",<br>  "Microsoft.EventGrid/domains": "domain",<br>  "Microsoft.EventGrid/topics": "topic",<br>  "Microsoft.EventHub/namespaces": "namespace",<br>  "Microsoft.HDInsight/clusters": "cluster",<br>  "Microsoft.HealthcareApis/services": "fhir",<br>  "Microsoft.Insights/privatelinkscopes": "azuremonitor",<br>  "Microsoft.IoTCentral/IoTApps": "IoTApps",<br>  "Microsoft.KeyVault/vaults": "vault",<br>  "Microsoft.Keyvault/managedHSMs": "HSM",<br>  "Microsoft.Kusto/clusters": "cluster",<br>  "Microsoft.MachineLearningServices/workspaces": "amlworkspace",<br>  "Microsoft.Media/mediaservices": "keydelivery, liveevent, streamingendpoint",<br>  "Microsoft.Migrate/assessmentProjects": "project",<br>  "Microsoft.Network/applicationgateways": "application gateway",<br>  "Microsoft.Network/privateLinkServices": "empty",<br>  "Microsoft.PowerBI/privateLinkServicesForPowerBI": "Power BI",<br>  "Microsoft.Purview/accounts": "account, portal",<br>  "Microsoft.RecoveryServices/vaults": "AzureBackup, AzureSiteRecovery",<br>  "Microsoft.Relay/namespaces": "namespace",<br>  "Microsoft.Search/searchServices": "searchService",<br>  "Microsoft.ServiceBus/namespaces": "namespace",<br>  "Microsoft.SignalRService/SignalR": "signalr",<br>  "Microsoft.SignalRService/webPubSub": "webpubsub",<br>  "Microsoft.Sql/servers": "sqlServer",<br>  "Microsoft.Storage/storageAccounts": "blob, blob_secondary, table, table_secondary, queue, queue_secondary, file, file_secondary, web, web_secondary, dfs, dfs_secondary",<br>  "Microsoft.StorageSync/storageSyncServices": "File Sync Service",<br>  "Microsoft.Synapse/privateLinkHubs": "web",<br>  "Microsoft.Synapse/workspaces": "Sql, SqlOnDemand, Dev",<br>  "Microsoft.Web/hostingEnvironments": "hosting environment",<br>  "Microsoft.Web/sites": "sites",<br>  "Microsoft.Web/staticSites": "staticSites"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_dns_configs"></a> [custom\_dns\_configs](#output\_custom\_dns\_configs) | The custom DNS configurations of the private endpoints. |
| <a name="output_endpoint_ids"></a> [endpoint\_ids](#output\_endpoint\_ids) | The IDs of the Private Endpoints. |
| <a name="output_ip_configurations"></a> [ip\_configurations](#output\_ip\_configurations) | A map of IP configurations for each private endpoint, keyed by the private endpoint name. |
| <a name="output_network_interfaces"></a> [network\_interfaces](#output\_network\_interfaces) | The network interfaces associated with the private endpoints. |
| <a name="output_private_dns_zone_configs"></a> [private\_dns\_zone\_configs](#output\_private\_dns\_zone\_configs) | The private DNS zone configurations of the private endpoints. |
| <a name="output_private_service_connections"></a> [private\_service\_connections](#output\_private\_service\_connections) | The private service connections of the private endpoints. |
| <a name="output_record_sets"></a> [record\_sets](#output\_record\_sets) | The record sets of the private endpoints. |
