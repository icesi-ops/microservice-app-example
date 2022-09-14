


module "logic" {
  source      = "../logic"
  location    = "East US"
  environment = "dev"
  service     = "distri"

}