#!/bin/bash
server_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
sed -i "s/Endpoint =.*:51820/Endpoint = $server_ip:51820/" /etc/wireguard/wg0-phone.conf
