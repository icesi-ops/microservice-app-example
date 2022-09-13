# DB network

resource "azurerm_subnet" "database_subnet" {
  name                 = "${local.name_convention_base}db_snet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_redis_cache" "redis" {
  name                = "${local.name_convention_base}redisCache"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
    #aof_storage_connection_string_0 = "DefaultEndpointsProtocol=https;BlobEndpoint=${azurerm_storage_account.nc-cruks-storage-account.primary_blob_endpoint};AccountName=${azurerm_storage_account.mystorageaccount.name};AccountKey=${azurerm_storage_account.mystorageaccount.primary_access_key}"
  }
}
