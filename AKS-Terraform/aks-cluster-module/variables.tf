
variable "aks_cluster_name" {
    description = "The name of the AKS cluster"
    type = string
}

variable "cluster_location" {
    description = "The Azure region where the cluster will be deployed"
    type = string 
}

variable "dns_prefix" {
    description = "The DNS prefix of the cluster"
    type = string
}

variable "kubernetes_version" {
  description = "Kubernetes version the cluster will use"
  type        = string
}

variable "service_principal_client_id" {
    description = "The client id of the service principal associated with the cluster"
    type = string
}

variable "service_principal_secret" {
    description = "The client secret for the service principal"
    type = string
}

# Input variables from networking-module

variable "resource_group_name" {
    description = "Name of the Azure Resource Group"
    type = string
}

variable "vnet_id" {
    description = "ID of the VNet"
    type = string
}

variable "control_plane_subnet_id" {
    description = "ID of the control plane subnet"
    type = string
}

variable "worker_node_subnet_id" {
    description = "ID of the worker node subnet"
    type = string
}
