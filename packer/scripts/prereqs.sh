#!/bin/bash
add-apt-repository ppa:wireguard/wireguard
apt-get update
apt-get upgrade -y
apt-get install wireguard qrencode htop -y
apt-get autoremove -y
