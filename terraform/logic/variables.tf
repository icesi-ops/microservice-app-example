

variable "resource_group_name" {
  type        = string
  default     = "rg"
  description = "Name for resource group"
}

variable "location" {
  type        = string
  default     = "East Us"
  description = "Azure Location"
}


variable "virtual_network_name" {
  type        = string
  default     = "vnet"
  description = "virtual network name"
}

variable "enviroment" {
  type        = string
  default     = "dev"
  description = "enviroment name"
}

variable "service" {
  type        = string
  default     = "distri"
  description = "service name"
}

variable "traffic_routing_method" {
  type        = string
  description  = "Specifies the algorithm used to route traffic"
  default   = "Weighted"
}