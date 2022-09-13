resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}


resource "azurerm_traffic_manager_profile" "tm" {
  name                   = "${local.name_convention_base}tm"
  resource_group_name    = azurerm_resource_group.resource_group.name
  traffic_routing_method = var.traffic_routing_method

  dns_config {
    relative_name = "tm-balles-lb"
    ttl           = 100
  }

  // ************************************** Customisar esta configuracion

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = {
    environment = var.environment
  }
}

# resource "azurerm_traffic_manager_endpoint" "endpoint" {
#   # provider = azurerm.tfprovider
#   # name = "${local.name_convention_base}endpint-tm"
#   # profile_id = azurerm_traffic_manager_profile.tm.id
#   # weight = 100
#   #target_resource_id = azurerm_public_ip.publicIP_lb.id
# 
#   name                = "${local.name_convention_base}endpint-tm"
#   resource_group_name = azurerm_resource_group.resource_group.name
#   profile_name        = azurerm_traffic_manager_profile.tm.name
#   target              = "terraform.io"
#   type                = "azureEndpoints"
#   weight              = 100
#   target_resource_id = "/subscriptions/5548a961-c253-4301-b04e-8e7e2778dddf/resourceGroups/${azurerm_resource_group.resource_group.name}/providers/Microsoft.Network/publicIPAddresses/${azurerm_public_ip.publicIP_lb.name}"
#   #target_resource_id  = "subscriptions/5548a961-c253-4301-b04e-8e7e2778dddf/resourceGroups/${azurerm_resource_group.resource_group.name}/providers/Microsoft.Network/publicIPAddresses/${azurerm_public_ip.publicIP_lb.name}"
# }

resource "azurerm_traffic_manager_azure_endpoint" "endpoint" {
  name               = "${local.name_convention_base}endpint-tm"
  profile_id         = azurerm_traffic_manager_profile.tm.id
  #profile_name       = azurerm_traffic_manager_profile.tm.name
  weight             = 100
  target_resource_id = "/subscriptions/5548a961-c253-4301-b04e-8e7e2778dddf/resourceGroups/${azurerm_resource_group.resource_group.name}/providers/Microsoft.Network/publicIPAddresses/${azurerm_public_ip.publicIP_lb.name}"
}
