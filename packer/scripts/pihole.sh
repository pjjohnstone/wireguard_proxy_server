mkdir /etc/pihole

cat <<EOT > /etc/pihole/setupVars.conf
DNSMASQ_LISTENING=single
DNS_FQDN_REQUIRED=true
DNS_BOGUS_PRIV=true
DNSSEC=false
CONDITIONAL_FORWARDING=false
PIHOLE_INTERFACE=wg0
IPV4_ADDRESS=10.0.0.1/24
IPV6_ADDRESS=
PIHOLE_DNS_1=127.0.0.1#5053
PIHOLE_DNS_2=
QUERY_LOGGING=false
INSTALL_WEB_SERVER=false
INSTALL_WEB_INTERFACE=false
LIGHTTPD_ENABLED=false
BLOCKING_ENABLED=true
EOT

curl -L https://install.pi-hole.net | bash /dev/stdin --unattended
