# Create a resource group
resource "azurerm_resource_group" "rg-test-prod2" {
  name     = "rg-test-prod2"
  location = "West India"
}