terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.20.0"
      #version = "2.71.0"
    }
  }
}

## Convención en los nombres de infrastructure
# convención: {environment}-{product/service}-{location}-{abreviation source}

# Ingresar a la consola de azure
# az login --use-device-code

provider "azurerm" {
  features {
  }
}

locals { # llamamos logica especial
  formated_location = replace(lower(var.location_name), " ", "")
  name_convention_base = "${var.environment}-${var.service}-${local.formated_location}-"
  public_key_file = file(var.key_local_path)
  machine_size = var.location_name == "East US" ?  "Standard_F2" : "Standard_DS1_v2"
  }

# Create a resource group
resource "azurerm_resource_group" "resource_group" {
  name     = "${local.name_convention_base}rg"
  location = var.location_name 
}


# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "${local.name_convention_base}vnet"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  address_space       = ["10.0.0.0/16"]
}

