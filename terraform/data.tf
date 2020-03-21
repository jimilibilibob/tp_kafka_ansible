data "azurerm_shared_image_gallery" "sig_gallery" {
  name                = var.sig_gallery_name
  resource_group_name = var.sig_gallery_resource_group
}

data "azurerm_shared_image_version" "image_tp" {
  name                = "1.0.0"
  image_name          = "imd-tp-stream"
  gallery_name        = data.azurerm_shared_image_gallery.sig_gallery.name
  resource_group_name = data.azurerm_shared_image_gallery.sig_gallery.resource_group_name
}