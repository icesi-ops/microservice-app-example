

resource "azurerm_traffic_manager_profile" "traffic_manager" {
  
  name                   = "${local.naming_convention}-tf"
  resource_group_name    = azurerm_resource_group.resource_group.name
  traffic_routing_method = var.traffic_routing_method

  dns_config {
    relative_name = "tf-chris-lb"
    ttl           = 100
  }

  monitor_config { #mejorar esto, como variables
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

}

resource "azurerm_traffic_manager_endpoint" "endpoint" {

    name                = "${local.naming_convention}-endpoint-tf"
    #name                = "${random_id.server.hex}"
    resource_group_name = azurerm_resource_group.resource_group.name
    profile_name        = azurerm_traffic_manager_profile.traffic_manager.name
    type                = "azureEndpoints"
    target_resource_id = "/subscriptions/3d6b57b0-c7bf-4a64-a206-80ab563622db/resourceGroups/${azurerm_resource_group.resource_group.name}/providers/Microsoft.Network/publicIPAddresses/${azurerm_public_ip.public_ip_lb.name}"
    weight              = 100
  
}
