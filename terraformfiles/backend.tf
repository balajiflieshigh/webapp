terraform {
  backend "azurerm" {
  resource_group_name  = "aks_terraform_web_rg"
  storage_account_name = "terrastorage2024"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
  }
}