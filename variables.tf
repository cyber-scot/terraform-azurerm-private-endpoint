variable "private_endpoints" {
  type = list(object({
    name                          = string
    location                      = string
    rg_name                       = string
    subnet_id                     = string
    custom_network_interface_name = optional(string)
    tags                          = optional(map(string))
    private_service_connection = optional(object({
      name                              = string
      is_manual_connection              = optional(bool)
      private_connection_resource_id    = optional(string)
      private_connection_resource_alias = optional(string)
      subresource_names                 = optional(list(string))
      request_message                   = optional(string)
    }))
    private_dns_zone_group = optional(object({
      name                 = string
      private_dns_zone_ids = optional(list(string))
    }))
    ip_configuration = optional(object({
      name               = string
      private_ip_address = optional(string)
      subresource_name   = optional(list(string))
      member_name        = optional(string)
    }))
  }))
  default = []
}

variable "sub_resource_names" {
  type        = map(string)
  description = "The sub resource names of private endpoints found at https://learn.microsoft.com/en-gb/azure/private-link/private-endpoint-overview#private-link-resource, not used, but provided for lookup option"
  default = {
    "Microsoft.Appconfiguration/configurationStores"         = "configurationStores"
    "Microsoft.Automation/automationAccounts"                = "Webhook, DSCAndHybridWorker"
    "Microsoft.AzureCosmosDB/databaseAccounts"               = "SQL, MongoDB, Cassandra, Gremlin, Table"
    "Microsoft.Batch/batchAccounts"                          = "batchAccount, nodeManagement"
    "Microsoft.Cache/Redis"                                  = "redisCache"
    "Microsoft.Cache/redisEnterprise"                        = "redisEnterprise"
    "Microsoft.CognitiveServices/accounts"                   = "account"
    "Microsoft.Compute/diskAccesses"                         = "managed disk"
    "Microsoft.ContainerRegistry/registries"                 = "registry"
    "Microsoft.ContainerService/managedClusters"             = "management"
    "Microsoft.DataFactory/factories"                        = "dataFactory"
    "Microsoft.Kusto/clusters"                               = "cluster"
    "Microsoft.DBforMariaDB/servers"                         = "mariadbServer"
    "Microsoft.DBforMySQL/servers"                           = "mysqlServer"
    "Microsoft.DBforPostgreSQL/servers"                      = "postgresqlServer"
    "Microsoft.Devices/provisioningServices"                 = "iotDps"
    "Microsoft.Devices/IotHubs"                              = "iotHub"
    "Microsoft.IoTCentral/IoTApps"                           = "IoTApps"
    "Microsoft.DigitalTwins/digitalTwinsInstances"           = "API"
    "Microsoft.EventGrid/domains"                            = "domain"
    "Microsoft.EventGrid/topics"                             = "topic"
    "Microsoft.EventHub/namespaces"                          = "namespace"
    "Microsoft.HDInsight/clusters"                           = "cluster"
    "Microsoft.HealthcareApis/services"                      = "fhir"
    "Microsoft.Keyvault/managedHSMs"                         = "HSM"
    "Microsoft.KeyVault/vaults"                              = "vault"
    "Microsoft.MachineLearningServices/workspaces"           = "amlworkspace"
    "Microsoft.Migrate/assessmentProjects"                   = "project"
    "Microsoft.Network/applicationgateways"                  = "application gateway"
    "Microsoft.Network/privateLinkServices"                  = "empty"
    "Microsoft.PowerBI/privateLinkServicesForPowerBI"        = "Power BI"
    "Microsoft.Purview/accounts"                             = "account, portal"
    "Microsoft.RecoveryServices/vaults"                      = "AzureBackup, AzureSiteRecovery"
    "Microsoft.Relay/namespaces"                             = "namespace"
    "Microsoft.Search/searchServices"                        = "searchService"
    "Microsoft.ServiceBus/namespaces"                        = "namespace"
    "Microsoft.SignalRService/SignalR"                       = "signalr"
    "Microsoft.SignalRService/webPubSub"                     = "webpubsub"
    "Microsoft.Sql/servers"                                  = "sqlServer"
    "Microsoft.Storage/storageAccounts"                      = "blob, blob_secondary, table, table_secondary, queue, queue_secondary, file, file_secondary, web, web_secondary, dfs, dfs_secondary"
    "Microsoft.StorageSync/storageSyncServices"              = "File Sync Service"
    "Microsoft.Synapse/privateLinkHubs"                      = "web"
    "Microsoft.Synapse/workspaces"                           = "Sql, SqlOnDemand, Dev"
    "Microsoft.Web/hostingEnvironments"                      = "hosting environment"
    "Microsoft.Web/sites"                                    = "sites"
    "Microsoft.Web/staticSites"                              = "staticSites"
    "Microsoft.Media/mediaservices"                          = "keydelivery, liveevent, streamingendpoint"
    "Microsoft.Authorization/resourceManagementPrivateLinks" = "ResourceManagement"
    "Microsoft.Databricks/workspaces"                        = "databricks_ui_api, browser_authentication"
    "Microsoft.Insights/privatelinkscopes"                   = "azuremonitor"
  }
}
