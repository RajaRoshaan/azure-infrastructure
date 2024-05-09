resource "azurerm_network_security_group" "webservers_nsg" {
  name                = "NSGWebservers"
  location            = azurerm_resource_group.webserver_rg.location
  resource_group_name = azurerm_resource_group.webserver_rg.name
}

# resource "azurerm_network_security_rule" "webservers_nsgrule" {
#   name                        = "Deny-Outbound"
#   priority                    = 100
#   direction                   = "Outbound"
#   access                      = "Deny"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.webserver_rg.name
#   network_security_group_name = azurerm_network_security_group.webservers_nsg.name
# }

resource "azurerm_subnet_network_security_group_association" "webservers_nsgsubnet_association" {
  subnet_id                 = azurerm_subnet.webservers_subnet1.id
  network_security_group_id = azurerm_network_security_group.webservers_nsg.id
}