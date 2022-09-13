module "logic_region_a" {
  source         = "../logic"
  location_name  = "East US"
  environment    = "dev"
  service        = "distribuited"
  vm_user        = "adminuser"
  key_local_path = "~/.ssh/id_rsa.pub"
}

