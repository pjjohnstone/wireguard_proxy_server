mkdir ~/cloudflared
wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb -O ~/cloudflared/cloudflared-stable-linux-amd64.deb
dpkg -i ~/cloudflared/cloudflared-stable-linux-amd64.deb

mkdir /etc/cloudflared
cat << EOF > /etc/cloudflared/config.yml
proxy-dns: true
proxy-dns-port: 5053
proxy-dns-upstream:
  - https://1.1.1.1/dns-query
  - https://1.0.0.1/dns-query
EOF

cloudflared service install
