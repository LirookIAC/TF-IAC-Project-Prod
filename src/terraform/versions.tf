terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"      
      version = ">= 3.112.0, < 4.0.0"
    }
  }
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {
  }
}
