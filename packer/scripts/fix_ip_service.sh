#!/bin/bash

mv /tmp/fixup_server_ip.sh /usr/local/bin/fixup_server_ip.sh
chown root:root /usr/local/bin/fixup_server_ip.sh
chmod +x /usr/local/bin/fixup_server_ip.sh

cat <<EOT > /etc/systemd/system/fixserverip.service
[Unit]
Description=Correct Server IP for Wireguard Config
After=network-online.target

[Service]
ExecStart=/usr/local/bin/fixup_server_ip.sh

[Install]
WantedBy=multi-user.target
EOT

systemctl enable fixserverip
