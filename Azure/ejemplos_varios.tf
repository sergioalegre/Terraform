# PS C:\Users\sergio.alegre> az login
# [
#   {
#     ...
#     "id": "", #este es el id de la suscripcion
#     ...
#   }
# ]


# PS C:\Users\sergio.alegre> az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<id de la suscripcion>"
# {
#   "appId": "",
#   ...
#   "password": "",
#   "tenant": ""
# }


#Datos de conexion
provider "azurerm" {
  subscription_id = "" # el valor de id
  client_id = "" # el valor de app_id
  client_secret = "" # el valor de password
  tenant_id = "" # el valor de tenant
  features {}
}

###### RESOURCE GROUP ######
resource "azurerm_resource_group" "rg_test_sergio" {
    name = "resorcegrouptestsergio"
    location = "West Europe"
}


###### NETWORK ######
resource "azurerm_virtual_network" "vn_test_sergio" {
  name                = "virtualnetworksergio"
  resource_group_name = azurerm_resource_group.rg_test_sergio.name
  location            = azurerm_resource_group.rg_test_sergio.location
  address_space       = ["10.0.0.0/16"]
}

###### STORAGE ######
resource "azurerm_storage_account" "sa_test_sergio" {#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob
  name                     = "storageaccountsergio"
  resource_group_name      = azurerm_resource_group.rg_test_sergio.name
  location                 = azurerm_resource_group.rg_test_sergio.location
  access_tier              = "Cool"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "co_test_sergio" {
  name                  = "containersergio"
  storage_account_name  = azurerm_storage_account.sa_test_sergio.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "bl_test_sergio" {
  name                   = "archivo.txt"
  storage_account_name   = azurerm_storage_account.sa_test_sergio.name
  storage_container_name = azurerm_storage_container.co_test_sergio.name
  type                   = "Block"
  source                 = "archivo.txt" #ruta absoluta al fichero
}

output "url" {
   value = "http://${azurerm_storage_account.sa_test_sergio.name}.blob.core.windows.net/${azurerm_storage_container.co_test_sergio.name}/${azurerm_storage_blob.bl_test_sergio.name}"
}
