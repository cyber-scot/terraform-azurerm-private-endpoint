module "rg" {
  source = "cyber-scot/rg/azurerm"

  name     = "rg-${var.short}-${var.loc}-${var.env}-01"
  location = local.location
  tags     = local.tags
}

module "network" {
  source = "cyber-scot/network/azurerm"

  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
  tags     = module.rg.rg_tags

  vnet_name          = "vnet-${var.short}-${var.loc}-${var.env}-01"
  vnet_location      = module.rg.rg_location
  vnet_address_space = ["10.0.0.0/16"]

  subnets = {
    "sn1-${module.network.vnet_name}" = {
      address_prefixes  = ["10.0.0.0/24"]
      service_endpoints = ["Microsoft.KeyVault"]
    }
  }
}

module "nsg" {
  source = "cyber-scot/nsg/azurerm"

  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
  tags     = module.rg.rg_tags

  nsg_name              = "nsg-${var.short}-${var.loc}-${var.env}-01"
  associate_with_subnet = true
  subnet_id             = element(values(module.network.subnets_ids), 0)
  custom_nsg_rules = {
    "AllowVnetInbound" = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    }
  }
}

module "key_vault" {
  source = "cyber-scot/key-vault/azurerm"

  key_vaults = [
    {
      name     = "kv-${var.short}-${var.loc}-${var.env}-01"
      rg_name  = module.rg.rg_name
      location = module.rg.rg_location
      tags     = module.rg.rg_tags
      contact = [
        {
          name  = "CyberScot"
          email = "info@cyber.scot"
        }
      ]
      network_acls = {
        default_action             = "Deny"
        bypass                     = "AzureServices"
        ip_rules                   = [chomp(data.http.client_ip.response_body)]
        virtual_network_subnet_ids = [module.network.subnets_ids["sn1-${module.network.vnet_name}"]]
      }
    }
  ]
}

module "private_endpoint" {
  source = "../../"

  private_endpoints = [
    {
      name     = "pep-${module.key_vault.key_vault_names[0]}"
      rg_name  = module.rg.rg_name
      location = module.rg.rg_location
      tags     = module.rg.rg_tags

      subnet_id                     = module.network.subnets_ids["sn1-${module.network.vnet_name}"]
      custom_network_interface_name = "nic-pep-${module.key_vault.key_vault_names[0]}"

      private_service_connection = {
        name                           = "psc-${module.key_vault.key_vault_names[0]}"
        is_manual_connection           = false
        private_connection_resource_id = module.key_vault.key_vault_ids[0]
        subresource_names              = ["vault"]
      }
    }
  ]
}
