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

#Crear resource group
resource "azurerm_resource_group" "rg_test_sergio" {
    name = "resorcegrouptestsergio"
    location = "West Europe"
}


# Crear virtual network dentro del resource group
resource "azurerm_virtual_network" "vn_test_sergio" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.rg_test_sergio.name
  location            = azurerm_resource_group.rg_test_sergio.location
  address_space       = ["10.0.0.0/16"]
}
