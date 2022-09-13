# Subnet backend
resource "azurerm_subnet" "backend_subnet" {
  name                 = "${local.name_convention_base}back_snet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# scale set
resource "azurerm_linux_virtual_machine_scale_set" "scale_set" {
  name                = "${local.name_convention_base}-vmss"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = var.vm_user
    public_key = local.public_key_file
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "${local.name_convention_base}-scale_nic"
    primary = true

    ip_configuration {
      name                          = "internal"
      primary                       = true
      subnet_id                     = azurerm_subnet.backend_subnet.id
      application_gateway_backend_address_pool_ids = "${azurerm_application_gateway.network.backend_address_pool[*].id}"
    }
  }
}


