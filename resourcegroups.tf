resource "azurerm_resource_group" "webserver_rg" {
  name     = "RGWebServers"
  location = var.location
}