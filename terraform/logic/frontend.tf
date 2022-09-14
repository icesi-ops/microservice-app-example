

resource "azurerm_availability_set" "front-availability" {
  name                = "${local.naming-convention}-front-ava"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

}

resource "azurerm_public_ip" "front_public_ip" {
  name                = "${local.naming-convention}-front-public-ip"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  allocation_method   = "Dynamic"

  
}

resource "azurerm_network_interface" "front_nic" {
  name                = "${local.naming-convention}-front-nic"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.subnet-frontend.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.front_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "front-vm" {
  name                = "${local.naming-convention}-front-vm"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password = "America192715"
  
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.front_nic.id,
  ]

  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}


resource "azurerm_public_ip" "public_ip_lb" {
  name                = "${local.naming-convention}-lb-public-ip"
  domain_name_label = "jamayora"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  allocation_method   = "Static"

  
}


resource "azurerm_lb" "load_balancer" {
  name                = "${local.naming-convention}-lb"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.public_ip_lb.id
  }
  
}

resource "azurerm_lb_backend_address_pool" "backeen_pool_lb" {
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = "BackEndAddressPool"


}

resource "azurerm_network_interface_security_group_association" "associacion" {
  network_interface_id = azurerm_network_interface.front_nic.id
  network_security_group_id = azurerm_network_security_group.front_ssh.id
}



resource "azurerm_network_interface_backend_address_pool_association" "backend_association" {
  network_interface_id    = azurerm_network_interface.front_nic.id
  ip_configuration_name   = "public"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backeen_pool_lb.id
}


resource "azurerm_network_security_group" "front_ssh" {
  name                = "${local.naming-convention}-front-ssh"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


}

