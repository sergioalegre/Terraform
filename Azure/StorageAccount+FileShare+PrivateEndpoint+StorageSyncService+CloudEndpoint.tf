#Sergio Alegre en 06/2023

### SCOPE:
# - Despliegue de Storage Sync Service con un File Share de 100Tb en un Storage Account que usa un Private Endpoint, declarar el Cloud Endpoint y añadir la cuenta de Microsoft.StorageSync mediante Role Assignment

### DEPENDENCIES:
# - permisos de Contributor sobre el Resource Group XXX (para crear el Private Endpoint) y el Resource Group YYY (para crear Private DNS Zone Group)
# - export $(grep -v '^#' ../../.env | xargs)

### FEATURES:
# - Usa dos suscripciones (2 providers azurerm)
# - provider random
# - private endpoint asociado a storage account
# - depends_on
# - azurerm_role_assignment

#Bloque Terraform
  terraform {
    required_providers {
      azurerm = {
      source = "hashicorp/azurerm"
      version = "3.58.0"
      }
      random = { # https://registry.terraform.io/providers/hashicorp/random/latest/docs
        source = "hashicorp/random"
        version = "3.5.1"
      }
    }
  }


#Bloque Providers
  provider "azurerm" { #Dev
    skip_provider_registration = "true"
    features {}
  }
  variable "subscription_id_common" {
    description = "value"
    type = string
  }
  provider "azurerm" { 
    skip_provider_registration = "true"
    subscription_id = var.subscription_id_common
    features { } 
    alias = "subscription_common" 
  }   

###########################
## ENTORNO DE DESARROLLO ##
###########################

#variables aleatorias
  resource "random_string" "nombre_aleatorio" {
    length              = 6
    upper               = false
    special             = false
  }
  resource "random_integer" "numero_aleatorio" {
    min                 = 990
    max                 = 999
  }

#Bloque Data
  variable "rgDEV" {
    description = "value"
    type = string
  }
  data "azurerm_resource_group" "rgDEVAFS" { # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group
    name = var.rgDEV
  }

#Bloque Resources
  #1:Storage account + Standard + LRS Large Files support + blob soft delete 30 días
    resource "azurerm_storage_account" "st" { # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
      name = "st${random_string.nombre_aleatorio.id}${random_integer.numero_aleatorio.id}"
      resource_group_name = data.azurerm_resource_group.rgDEVAFS.name
      location = data.azurerm_resource_group.rgDEVAFS.location
      account_tier = "Standard"
      account_replication_type = "LRS"
      large_file_share_enabled = true
      blob_properties {
        delete_retention_policy {
          days = 30
        }
      }
    }

  #2:Private Endpoint (Requiere: virtual network + Subnet + Private DNS Zone)
    variable "virtualNetworkDEV" {
      description = "value"
      type = string
    }
     variable "networkDEVRG" {
       description = "value"
       type = string
     }
    data "azurerm_virtual_network" "virtualnetwork" { # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network
      name                = var.virtualNetworkDEV
      resource_group_name = var.networkDEVRG
    }

    variable "subnetDEV" {
      description = "value"
      type = string
    }
    data "azurerm_subnet" "subnet" { # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet
      name                 = var.subnetDEV
      resource_group_name  = var.networkDEVRG
      virtual_network_name = data.azurerm_virtual_network.virtualnetwork.name
    }

    data "azurerm_private_dns_zone" "privateazuredns" { # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone
      name                = "privatelink.file.core.windows.net"
      resource_group_name = "rg-privateazuredns"
      provider = azurerm.subscription_common #este RG esta en otra suscripcion por lo que lo ha de leer de otro provider
    }

    resource "azurerm_private_endpoint" "pep" { # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
      name = "pep${random_string.nombre_aleatorio.id}${random_integer.numero_aleatorio.id}"
      resource_group_name = data.azurerm_resource_group.rgDEVAFS.name
      location = data.azurerm_resource_group.rgDEVAFS.location
      subnet_id = data.azurerm_subnet.subnet.id

      private_service_connection {
        name                           = "private-endpoint-connection"
        private_connection_resource_id = azurerm_storage_account.st.id
        subresource_names              = ["file"]
        is_manual_connection           = false
      }

      ### XXX integrate with private DNS zone: No OJO NO LO ENCUENTRO ###

      private_dns_zone_group {
        name = "private-dns-zone-group"
        private_dns_zone_ids = [
          data.azurerm_private_dns_zone.privateazuredns.id,
        ]
      }    
    }

  #3:Storage Sync Group
  resource "azurerm_storage_sync" "ss" { #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_sync
    name  = "sss-public-${random_string.nombre_aleatorio.id}-${random_integer.numero_aleatorio.id}"
    resource_group_name = data.azurerm_resource_group.rgDEVAFS.name
    location = data.azurerm_resource_group.rgDEVAFS.location
  }

  resource "azurerm_storage_sync_group" "ssg" { #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_sync
    name = "sg-public-${random_string.nombre_aleatorio.id}-${random_integer.numero_aleatorio.id}"
    storage_sync_id = azurerm_storage_sync.ss.id
  }

  resource "azurerm_storage_share" "sh" { #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share
    name = "fspublic${random_string.nombre_aleatorio.id}${random_integer.numero_aleatorio.id}"
    storage_account_name = azurerm_storage_account.st.name
    access_tier = "Cool"
    quota = 102400 #100Tb
  }

  #La APP Microsoft.StorageSync necesita permisos de "Reader and Data Access" sobre la storage account, asi que a mano hemos de dar a nuestra cuenta de servicio el rol de "Role Assignment Writer"
  variable "Microsoft_StorageSync_id" {
    description = "value"
    type = string
    
  }
  variable "StorageSync_Scope" {
    description = "value"
    type = string
  }
  resource "azurerm_role_assignment" "sync_role" { # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
    scope                = var.StorageSync_Scope
    role_definition_name = "Reader and Data Access"
    principal_id         = var.Microsoft_StorageSync_id
  }
  resource "azurerm_storage_sync_cloud_endpoint" "sce" { # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_sync_cloud_endpoint
    name                  = "fspublictst002-cloudendpoint"
    storage_sync_group_id = azurerm_storage_sync_group.ssg.id
    file_share_name       = azurerm_storage_share.sh.name
    storage_account_id    = azurerm_storage_account.st.id

    depends_on = [ azurerm_role_assignment.sync_role ]
  }  


#4:Pasos a mano necesarios:
  #4.1 Descargar e instalar el agente en el endpoint
  #4.2 Añadir el server endpoint en el SyncGroup ya creado
  #4.3 En el Storage Account / Networking / Firewalls and virtual networks / activar: Enabled from selected virtual networks and IP addresses

###########################
## ENTORNO DE PRODUCCION ##
###########################