

# Configure the Microsoft Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.71.0"
    }
  }
}
provider "azurerm" {
 
  features {}
}

locals {
  location_formatted =replace(lower(var.location)," ","")
  naming_convention = "${var.environment}-${var.service}-${local.location_formatted}"
  #key_rsa  = file("C:\Users\Chris\.ssh\id_ed25519.pub")
  #machine_region = var.location_formatted == "East US" ? "Standard F2" : "Standard D1"
}
# Create a resource group
resource "azurerm_resource_group" "resource_group" {
  name     = "${local.naming_convention}-rg" 
  location = var.location
  
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "${local.naming_convention}-vnet"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  address_space       = ["10.0.0.0/16"]
}

#Create a subnet fronted within the virtual network 
resource "azurerm_subnet" "subnet_fronted" {
  name                 = "${local.naming_convention}-fronted-sn"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  
}

#Create a subnet backend within the virtual network 
resource "azurerm_subnet" "subnet_backend" {
  name                 = "${local.naming_convention}-backend-sn"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

  
}
#Create a subnet app gateway within the virtual network 
resource "azurerm_subnet" "subnet_app_gateway" {
  name                 = "${local.naming_convention}-gateway-sn"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]

  
}
