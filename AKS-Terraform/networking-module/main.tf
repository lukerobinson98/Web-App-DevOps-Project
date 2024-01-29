resource "azurerm_resource_group" "aks_resource_group" {
    name     = var.resource_group_name
    location = var.location
}

resource "azurerm_virtual_network" "aks_vnet" {
    name                = "aks-vnet"
    resource_group_name = azurerm_resource_group.aks_resource_group.name
    location            = var.location
    address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "control_plane_subnet" {
    name                 = "control-plane-subnet"
    resource_group_name  = azurerm_resource_group.aks_resource_group.name
    virtual_network_name = azurerm_virtual_network.aks_vnet.name
    address_prefixes     = ["${cidrsubnet(var.vnet_address_space[0], 4, 0)}"]
}

resource "azurerm_subnet" "worker_node_subnet" {
    name                 = "worker-node-subnet"
    resource_group_name  = azurerm_resource_group.aks_resource_group.name
    virtual_network_name = azurerm_virtual_network.aks_vnet.name
    address_prefixes     = ["${cidrsubnet(var.vnet_address_space[0], 4, 1)}"]
}

resource "azurerm_network_security_group" "aks_nsg" {
    name                = "aks-nsg"
    resource_group_name = azurerm_resource_group.aks_resource_group.name
    location = var.location
}

resource "azurerm_network_security_rule" "kube_apiserver_rule" {
    name                        = "kube-apiserver-rule"
    priority                    = 1001
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_address_prefix       = "2a00:23c8:a82:bb01:a466:de37:a66:d73e"
    source_port_range           = "*"
    destination_address_prefix  = "*"
    destination_port_range      = "6443"
    resource_group_name         = azurerm_resource_group.aks_resource_group.name
    network_security_group_name = azurerm_network_security_group.aks_nsg.name
}

resource "azurerm_network_security_rule" "ssh_rule" {
    name                        = "ssh-rule"
    priority                    = 1002
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_address_prefix       = "2a00:23c8:a82:bb01:a466:de37:a66:d73e"
    source_port_range           = "*"
    destination_address_prefix  = "*"
    destination_port_range      = "22"
    resource_group_name         = azurerm_resource_group.aks_resource_group.name
    network_security_group_name = azurerm_network_security_group.aks_nsg.name
}