resource "azurerm_virtual_network" "webservers_vnet" {
  name                = "VNetWebservers"
  location            = azurerm_resource_group.webserver_rg.location
  resource_group_name = azurerm_resource_group.webserver_rg.name
  address_space       = ["10.0.0.0/24"] # 10.0.0.1 - 10.0.0.254 
}

resource "azurerm_subnet" "webservers_subnet1" {
  name                 = "SNet1Webservers"
  resource_group_name  = azurerm_resource_group.webserver_rg.name
  virtual_network_name = azurerm_virtual_network.webservers_vnet.name
  address_prefixes     = ["10.0.0.64/26"] # 10.0.0.65 - 10.0.0.126
}

resource "azurerm_public_ip" "webservers_winvm_publicip" {
  name                = "WinVMPublicIPWebservers"
  resource_group_name = azurerm_resource_group.webserver_rg.name
  location            = azurerm_resource_group.webserver_rg.location
  allocation_method   = "Static"
}