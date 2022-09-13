## Vars
variable "resource_group_name" {
  description = "Resource name"
  default     = "rg"
  type        = string
}

variable "location_name" {
  description = "Location name"
  default     = "East US"
  type        = string
}

variable "virtual_network_name" {
  description = "Network name"
  default     = "vnet"
  type        = string
}

variable "environment" {
  description = "Env type"
  default = "dev"
  type = string
}

variable "service" {
  description = "Service name"
  default = "distribuidos"
  type = string
}

variable "vm_user" {
  description = "Service name"
  default = "admin"
  type = string
}

variable "traffic_routing_method" {
  description = " how traffic is routed"
  default = "Weighted"
  type = string
}


variable "key_local_path" {
  description = "Path where is the key to store to connect using SSH"
  default = "~/.ssh/id_rsa.pub"
  type = string
}

