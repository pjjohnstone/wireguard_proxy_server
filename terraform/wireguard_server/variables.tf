variable "location" {
  default = "northeurope"
}

variable "prefix" {
  default = "wireguard"
}

variable "vm_size" {
  default = "Standard_B1LS"
}

variable "admin_username" {
  default = "wgadmin"
}

variable "ssh_allowed_cidr" {}

variable "wireguard_listen_port" {
  default = "51820"
}

variable "packer_image_name" {}

variable "packer_image_rg" {}
