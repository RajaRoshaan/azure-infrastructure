resource "azurerm_network_interface" "webservers_winvm_nic" {
  name                = "WinVMNICWebservers"
  location            = azurerm_resource_group.webserver_rg.location
  resource_group_name = azurerm_resource_group.webserver_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.webservers_subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webservers_winvm_publicip.id
  }
}

resource "azurerm_windows_virtual_machine" "webservers_winvm" {
  name                = "WinVMWebservers"
  resource_group_name = azurerm_resource_group.webserver_rg.name
  location            = azurerm_resource_group.webserver_rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"

  network_interface_ids = [
    azurerm_network_interface.webservers_winvm_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

}

resource "azurerm_managed_disk" "webservers_winvm_disk" {
  name                 = "Data"
  location             = azurerm_resource_group.webserver_rg.location
  resource_group_name  = azurerm_resource_group.webserver_rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "5"
}

resource "azurerm_virtual_machine_data_disk_attachment" "webservers_winvm_diskattachment" {
  managed_disk_id    = azurerm_managed_disk.webservers_winvm_disk.id
  virtual_machine_id = azurerm_virtual_machine.webservers_winvm.id
  lun                = "5"
  caching            = "ReadWrite"
}