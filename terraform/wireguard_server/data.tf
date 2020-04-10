data "azurerm_image" "img" {
  name                = var.packer_image_name
  resource_group_name = var.packer_image_rg
}
