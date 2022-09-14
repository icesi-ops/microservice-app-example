



module "logic"{
   # source ="/Users/andresmayor/azure/logic/main.tf"
    source = "../logic"
    location = "East US"    
    enviroment = "dev"
    service = "distri"

}