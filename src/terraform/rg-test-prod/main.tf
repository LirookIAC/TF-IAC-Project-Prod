# Create a resource group
resource "azurerm_resource_group" "rg-test-prod" {
  name     = "rg-test-prod"
  location = "West India"
}