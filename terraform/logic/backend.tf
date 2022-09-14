

resource "azurerm_public_ip" "application_public_ip" {
  name                = "${local.naming-convention}-application-public-ip"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  allocation_method   = "Dynamic"
}




resource "azurerm_network_interface" "back_nic" {
  name                = "${local.naming-convention}-back-nic"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.subnet-backend.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine_scale_set" "vm_escale_set" {
  name                            = "${local.naming-convention}-vm-escale-set"
  resource_group_name             = azurerm_resource_group.resourcegroup.name
  location                        = azurerm_resource_group.resourcegroup.location
  sku                             = "Standard_F2"
  instances                       = 1
  admin_username                  = "adminuser"
  admin_password                  = "America192715"
  disable_password_authentication = false

  #network_interface_ids = [
  #  azurerm_network_interface.back_nic.id,
  #]

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
 # ip_configuration {
 #   name                                         = "public"
 #   primary                                      = true
 #   subnet_id                                    = azurerm_subnet.subnet_backend
 #   private_ip_address_allocation                = "Dynamic"
 #   public_ip_address_id                         = azurerm_public_ip.back_public_ip.id
 #   application_gateway_backend_address_pool_ids = azurerm_application_gateway.app_gateway.backend_address_pool[0].id
 # }

    network_interface {
    name    = "${local.naming-convention}-net-inter"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.subnet-backend.id
      application_gateway_backend_address_pool_ids = "${azurerm_application_gateway.application_gateway.backend_address_pool[*].id}"
    }
  }

}


resource "azurerm_application_gateway" "application_gateway" {
  name                = "${local.naming-convention}-app-gtw"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.subnet-application.id
  }

  frontend_port {
    name = "${local.naming-convention}-frontend-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${local.naming-convention}-front-ip-configuration"
    public_ip_address_id = azurerm_public_ip.application_public_ip.id
  }

  backend_address_pool {
    name ="${local.naming-convention}-backend-address-pool"
  }

  backend_http_settings {
    name                  = "${local.naming-convention}-backend-http-settings"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "${local.naming-convention}-backend-http-settings-listener"
    frontend_ip_configuration_name = "${local.naming-convention}-front-ip-configuration"
    frontend_port_name             ="${local.naming-convention}-frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${local.naming-convention}-backend-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "${local.naming-convention}-backend-http-settings-listener"
    backend_address_pool_name  ="${local.naming-convention}-backend-address-pool"
    backend_http_settings_name = "${local.naming-convention}-backend-http-settings"
  }
}


