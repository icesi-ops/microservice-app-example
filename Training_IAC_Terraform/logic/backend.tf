resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = "${local.naming_convention}-app-gateway-public-ip"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name 
  allocation_method = "Dynamic"

 
}


resource "azurerm_linux_virtual_machine_scale_set" "back_vmss" {
  name                = "${local.naming_convention}-back-vmss"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"
admin_password = "#Tomate2022"
  disable_password_authentication = false
    
    network_interface {
        name    = "${local.naming_convention}-back-nic"
        primary = true
        ip_configuration {
            name                          = "primary"
            subnet_id                     = azurerm_subnet.subnet_backend.id
            application_gateway_backend_address_pool_ids = "${azurerm_application_gateway.app_gateway.backend_address_pool[*].id}"
            #private_ip_address_allocation = "Dynamic"
            #public_ip_address_id          = azurerm_public_ip.app_gateway_public_ip.id
        }
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

}

resource "azurerm_application_gateway" "app_gateway" {
  name                = "${local.naming_convention}-app-gateway"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.subnet_app_gateway.id
  }

  frontend_port {
    name = "${local.naming_convention}-frontend_port_80"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${local.naming_convention}-frontend_ip_configuration"
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }

  backend_address_pool {
    name = "${local.naming_convention}-backend_address_pool"
  }

  backend_http_settings {
    name                  = "${local.naming_convention}-backend_http_settings"
    cookie_based_affinity = "Disabled"
    path                  = "/back/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "${local.naming_convention}-http_listener"
    frontend_ip_configuration_name = "${local.naming_convention}-frontend_ip_configuration"
    frontend_port_name             = "${local.naming_convention}-frontend_port_80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${local.naming_convention}-request_routing_rule"
    rule_type                  = "Basic"
    http_listener_name         = "${local.naming_convention}-http_listener"
    backend_address_pool_name  = "${local.naming_convention}-backend_address_pool"
    backend_http_settings_name = "${local.naming_convention}-backend_http_settings"
  }
}

#resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "back_nic_app_gateway" {
 # count = 2
  #network_interface_id    = azurerm_linux_virtual_machine_scale_set.back_vmss.network_interface_id
  #ip_configuration_name   = "nic-ipconfig-${count.index+1}"
  #backend_address_pool_id = azurerm_application_gateway.app_gateway.backend_address_pool[0].id
#}