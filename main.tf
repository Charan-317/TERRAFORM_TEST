#Resource Group
resource "azurerm_resource_group" "main" {
    name     = var.resource_group_name
    location = var.location
}

#vnet and subnet
resource "azurerm_virtual_network" "main" {
    name                = var.vnet_name
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.main.location  
    resource_group_name = azurerm_resource_group.main.name
    }

resource "azurerm_subnet" "main" {
    name                 = var.subnet_name
    resource_group_name  = azurerm_resource_group.main.name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = ["10.0.1.0/24"]
}

#Network Security Group
resource "azurerm_network_security_group" "main" {
    name                = var.nsg_name
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name  
}

resource "azurerm_subnet_network_security_group_association" "main" {
    subnet_id                 = azurerm_subnet.main.id
    network_security_group_id = azurerm_network_security_group.main.id
}   

resource "azurerm_key_vault" "main" {
    name                        = var.kv_name
    location                    = azurerm_resource_group.main.location
    resource_group_name         = azurerm_resource_group.main.name
    tenant_id                   = data.azurerm_client_config.current.tenant_id
    sku_name                    = "standard"
}

data "azurerm_client_config" "config" {}


resource "azurerm_storage_account" "main" {
    name                     = var.storage_account_name
    resource_group_name      = azurerm_resource_group.main.name
    location                 = azurerm_resource_group.main.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_mysql_flexible_server" "main" {
    name                = var.mysql_name
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
    version             = "8.0.21"
    administrator_login = var.mysql_admin
    administrator_password = var.mysql_password
    sku_name = "B_Standard_B1ms"
    delegated_subnet_id = azurerm_subnet.main.id
    backup_retention_days = 7
    zone = "1"
    storage {
        size_gb = 32
        iops = 360
        auto_grow_enabled = false
    }
  
}

resource "azurerm_service_plan" "main" {
    name                = var.app_service_plan_name
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
    os_type             = "Linux"
    sku_name           = "B1"
}


resource "azure_linux_web_app" "app1" {
    name                = var.app_service_name
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
    service_plan_id     = azurerm_service_plan.main.id
    site_config {

    }
}