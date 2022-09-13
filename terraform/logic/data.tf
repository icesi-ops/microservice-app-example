# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "redis-data" {
  name                = "${local.naming-convention}-redis-data"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}