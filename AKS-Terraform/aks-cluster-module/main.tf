# Create AKS cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
    name = var.aks_cluster_name
    location = var.cluster_location
    resource_group_name = var.resource_group_name
    dns_prefix = var.dns_prefix
    kubernetes_version = var.kubernetes_version

    default_node_pool {
        name = "default"
        node_count = 1
        vm_size = "Standard_D2_v2"
    }

    service_principal {
        client_id = var.service_principal_client_id
        client_secret = var.service_principal_secret
    }

    network_profile {
        network_plugin = "azure"
        service_cidr = "10.0.0.0/16"
        dns_service_ip = "10.0.0.10"
        docker_bridge_cidr = "172.17.0.1/16"
    }
}
