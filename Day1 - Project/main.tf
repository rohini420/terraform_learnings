terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  subscription_id  = "your-subscription-id-here"
  client_id = "your-client-id-here"
  tenant_id = "your-tenant-id-here"
  client_secret = "your-client-secret-here"
  
}
resource "azurerm_resource_group" "rg1" {
  location = "East US"
  name     = "terraform_rg1"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "terraform_vnet1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "terraform_subnet1"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.10.1.0/24"]
}