
variable "resource_group_name" {
    description = "Name of Azure Resource Group"
    type        = string
    default     = "myResourceGroup"
}

variable "location" {
    description = "Azure region for resources"
    type        = string
    default     = "UK South"
}

variable "vnet_address_space" {
    description = "Address space for the Vnet"
    type        = list(string)
    default     = ["10.0.0.0/16"]
}