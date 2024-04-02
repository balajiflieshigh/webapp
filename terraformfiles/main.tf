resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
# creating azure container registry

resource "azurerm_container_registry" "acr" {
  name                = var.container_registry
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false
  depends_on = [ azurerm_resource_group.rg ]
}

# creating an AKS cluster

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name
  #node_resource_group = var.node_resource_group

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    # availability_zones  = [1, 2, 3]
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet" # azure (CNI)
  }

}

# creating role assignment for aks acr pull

resource "azurerm_role_assignment" "acraks" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
# creating storage account
resource "azurerm_storage_account" "terraformstorage2024" {
  name                     = var.storage
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  depends_on = [ azurerm_resource_group.rg ]
}

# creating storage account container
resource "azurerm_storage_container" "tfstate" {
  name                  = var.container
  storage_account_name  = var.storage
  container_access_type = "blob"
  depends_on = [ azurerm_storage_account.terraformstorage2024 ]
}