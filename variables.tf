variable "location" { default = "East US" } 
variable "resource_group_name" { default = "rg-terraform-example" }
variable "storage_account_name" { default = "stexample123456" }
variable "vnet_name" { default = "vnet-example" }
variable "subnet_name" { default = "subnet-example" }
variable "nsg_name" { default = "nsg-example" }
variable "kv_name" { default = "kv-example" }
variable "mysql_name" { default = "mysql-example" }  
variable "mysql_admin" { default = "adminuser" }
variable "mysql_password" {}
variable "app_service_plan_name" { default = "appserviceplan-example" }
variable "app_service_name" { default = "appservice-example" }
  