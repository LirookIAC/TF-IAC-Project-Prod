terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.40.0"
    }
  }
  backend "azurerm" {}

}

provider "azurerm" {
  features {}
  subscription_id = "bed9c8b2-bb60-492d-92a9-d1641fb7adf8"
}