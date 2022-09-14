

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.71.0"
    }
  }
}

provider "azurerm" {
   
  features {}
}

#hacer logica en terraform para despues llamarla y aplicarla en terrafor necetamos
locals {
    location_formatted = replace(lower(var.location)," ","")
    naming-convention  = "${var.enviroment}-${var.service}-${local.location_formatted}"
}




resource "azurerm_resource_group" "resourcegroup" {
  name     = "${local.naming-convention}-rg"
  location = var.location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
    name     = "${local.naming-convention}-vnet"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet-frontend" {
  name                 = "${local.naming-convention}-fronted-sn"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  
}

resource "azurerm_subnet" "subnet-backend" {
  name                 = "${local.naming-convention}-backend-sn"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

}


resource "azurerm_subnet" "subnet-application" {
  name                 = "${local.naming-convention}-application"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]

 
}
