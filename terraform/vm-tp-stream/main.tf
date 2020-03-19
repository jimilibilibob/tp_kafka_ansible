provider "azurerm" {
    version         = "2.0.0"
    subscription_id = var.subscription_id
    features {}
}

resource "azurerm_resource_group" "main" {
    name     = "net-${var.env}-rg"
    location = var.location
}

resource "azurerm_virtual_network" "main" {
    name                = "${var.env}-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
    name                 = "${var.env}-snet"
    resource_group_name  = azurerm_resource_group.main.name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefix       = "10.0.2.0/24"
}

resource "random_password" "vm_admin_password" {
    length      = 16
    min_upper   = 1
    min_lower   = 1
    min_numeric = 1
    min_special = 1
    override_special = "-_!?,:;."
    count = var.nombre_ressource
}

resource "azurerm_resource_group" "sub" {
    name     = "vm-${var.env}-${count.index}-rg"
    location = var.location
    count = var.nombre_ressource
}

resource "azurerm_public_ip" "sub" {
    name                = "${var.env}-${count.index}-public-ip"
    location            = azurerm_resource_group.sub[count.index].location
    resource_group_name = azurerm_resource_group.sub[count.index].name
    allocation_method   = "Dynamic"
    count = var.nombre_ressource
}

resource "azurerm_network_interface" "sub" {
    name                = "nic-${var.env}-${count.index}"
    location            = azurerm_resource_group.sub[count.index].location
    resource_group_name = azurerm_resource_group.sub[count.index].name

    ip_configuration {
        name                          = "testconfiguration1"
        subnet_id                     = azurerm_subnet.main.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.sub[count.index].id
    }

    

    count = var.nombre_ressource
}

## VM
resource "azurerm_virtual_machine" "sub" {
    name                = "stream-${var.env}-${count.index}-vm"
    location            = azurerm_resource_group.sub[count.index].location
    resource_group_name = azurerm_resource_group.sub[count.index].name

    primary_network_interface_id = azurerm_network_interface.sub[count.index].id
    network_interface_ids = [azurerm_network_interface.sub[count.index].id]
    vm_size = "Standard_B2s"

    delete_os_disk_on_termination = true

    storage_image_reference {
        id = data.azurerm_shared_image_version.image_pki.managed_image_id
    }

    storage_os_disk {
        name              = "vm_osdisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    os_profile {
        computer_name  = "hostname"
        admin_username = "usertp202003"
        admin_password = random_password.vm_admin_password[count.index].result
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    identity {
        type = "SystemAssigned"
    }

    count = var.nombre_ressource

}
