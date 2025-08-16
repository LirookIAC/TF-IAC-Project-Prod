# Create a resource group
resource "azurerm_resource_group" "rg-test-prod2" {
  name     = "rg-test-prod2"
  location = "West India"
}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.rg-test-prod2.location
  resource_group_name = azurerm_resource_group.rg-test-prod2.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

