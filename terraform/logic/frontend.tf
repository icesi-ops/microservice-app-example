## Subnet set
resource "azurerm_subnet" "frontend_subnet" {
  name                 = "${local.name_convention_base}front_snet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}


## Availability Set
resource "azurerm_availability_set" "aviability_set" {
  name                = "${local.name_convention_base}avset"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = {
    environment = var.environment
  }
}


## VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${local.name_convention_base}vm"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  size                = local.machine_size
  admin_username      = var.vm_user
  availability_set_id = azurerm_availability_set.aviability_set.id

  network_interface_ids = [
    azurerm_network_interface.vm_i.id,
  ]

  # **************** Customizar
  admin_password = "#HolaFrailejon"

  admin_ssh_key {
    username   = var.vm_user
    public_key = local.public_key_file
  }

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

## VM interface
resource "azurerm_network_interface" "vm_i" {
  name                = "${local.name_convention_base}-vm_nic"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.frontend_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicIP_VM.id
  }
}

## Public IP Address VM
resource "azurerm_public_ip" "publicIP_VM" {
  name                = "${local.name_convention_base}vmIP"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
}


## Load balancer
resource "azurerm_lb" "loadBalancer" {
  name                = "${local.name_convention_base}-lb"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.publicIP_lb.id
  }
}

## IP Load balancer
resource "azurerm_public_ip" "publicIP_lb" {
  name                = "${local.name_convention_base}lbIP"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
  domain_name_label   = "lbballesdistri"
}

## Backend pool
resource "azurerm_lb_backend_address_pool" "backend_pool_lb" {
  name            = "BackendAddressPool"
  loadbalancer_id = azurerm_lb.loadBalancer.id
}

resource "azurerm_network_interface_backend_address_pool_association" "pool_association" {
  network_interface_id    = azurerm_network_interface.vm_i.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool_lb.id
}


## Security Group
resource "azurerm_network_security_group" "secGroup" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  tags = {
    environment = "Production"
  }
}


resource "azurerm_network_interface_security_group_association" "secAsso" {
  network_interface_id      = azurerm_network_interface.vm_i.id
  network_security_group_id = azurerm_network_security_group.secGroup.id
}
