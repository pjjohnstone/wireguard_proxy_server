# WireGuard & DNS Proxy Server

## TODO

1. Fix the IP fixing service DNS issue
2. Support other cloud providers

## Requirements

- Terraform
- Packer
- Azure subscription

## Usage

### Create the image with Packer

`cd /packer`

`packer build -var "subscription_id=<your azure subscription id>" ./wireguard_server_image.json`

You can also pass in the name of the resource group you want to store your image in, and a custom ssh port number, e.g.

`-var "managed_image_resource_group_name=<an existing rg to store the image>`

`-var "ssh_port=<some random high port number>`

These default to `packerimages` and `22389` respectively.

### Terraform up the server

`cd /terraform/wireguard_server`

`terraform apply`

Lots of vars for this one so you might want to prepare a tfvars file:
```
ssh_allowed_cidr = <a range to allow ssh from>
admin_username = <admin username for the os>
packer_image_rg= <the resource group you saved the image to>
packer_image_name = <the image name>
ssh_port = <your chosen ssh port>
```
