

resource "azurerm_traffic_manager_profile" "traffic_manager" {

  name                   = "${local.naming-convention}-tf"
  resource_group_name    = azurerm_resource_group.resourcegroup.name
  traffic_routing_method = var.traffic_routing_method

  dns_config {
    relative_name = "tf-andres-lb"//aca hacemos el llamado al load balancer
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

}

resource "azurerm_traffic_manager_endpoint" "endpoint" {

  name                = "${local.naming-convention}-tf-endpoint" 
 resource_group_name = azurerm_resource_group.resourcegroup.name
  profile_name        = azurerm_traffic_manager_profile.traffic_manager.name
  type                = "azureEndpoints"
  weight              = 100
target_resource_id = "/subscriptions/7ec9fb52-f3a8-4ce6-b66d-395aab9e9f0d/resourceGroups/${azurerm_resource_group.resourcegroup.name}/providers/Microsoft.Network/publicIPAddresses/${azurerm_public_ip.public_ip_lb.name}"
}


  