#!/bin/bash
mkdir /etc/pihole

cat <<EOT > /etc/pihole/setupVars.conf
DNSMASQ_LISTENING=single
DNS_FQDN_REQUIRED=true
DNS_BOGUS_PRIV=true
DNSSEC=false
CONDITIONAL_FORWARDING=false
PIHOLE_INTERFACE=wg0
IPV4_ADDRESS=10.0.0.1
IPV6_ADDRESS=
PIHOLE_DNS_1=127.0.0.1#5053
PIHOLE_DNS_2=
QUERY_LOGGING=false
INSTALL_WEB_SERVER=true
INSTALL_WEB_INTERFACE=true
LIGHTTPD_ENABLED=true
BLOCKING_ENABLED=true
EOT

git clone https://github.com/pi-hole/pi-hole.git /etc/.pihole
bash "/etc/.pihole/automated install/basic-install.sh" --unattended
