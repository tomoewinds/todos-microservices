resource "azurerm_resource_group" "rg" {
  name     = "rg-todosapp"
  location = "East US" 
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-todosapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "todosapp"
  
  network_profile{
    network_plugin = "kubenet"
    network_policy = "calico"
  }
  default_node_pool {
    name       = "default"
    node_count = 2       
    vm_size    = "Standard_B2s" 
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "RampUp"
  }
}
