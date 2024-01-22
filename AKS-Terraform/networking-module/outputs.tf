
output "vnet_id" {
    description = "The ID of the VNet"
    value       = azurerm_virtual_network.aks_vnet.id
}

output "control_plane_subnet_id" {
    description = "The ID of the Control Plane Subnet"
    value       = azurerm_subnet.control_plane_subnet.id
}

output "worker_node_subnet_id" {
    description = "The ID of the Worker Node Subnet"
    value       = azurerm_subnet.worker_node_subnet.id
}

output "networking_resource_group_name" {
    description = "The name of the Azure Resource Group for networking resources"
    value       = azurerm_resource_group.aks_resource_group.name
}

output "aks_nsg_id" {
    description = "The ID of the Network Security Group"
    value       = azurerm_network_security_group.aks_nsg.id
}