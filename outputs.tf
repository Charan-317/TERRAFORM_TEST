output "resource_group" {  value = azurerm_resource_group.main.name}
output "vnet" { value = azurerm_virtual_network.main.name }
output "subnet" { value = azurerm_subnet.main.name }
output "nsg" { value = azurerm_network_security_group.main.name }
output "storage_account" { value = azurerm_storage_account.main.name }
output "key_vault" { value = azurerm_key_vault.main.name }
output "mysql_server" { value = azurerm_mysql_flexible_server.main.name }
output "app1" { value = azurerm_linux_web_app.app1.default_hostname }