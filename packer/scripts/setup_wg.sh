mkdir /etc/wireguard/keys
cd /etc/wireguard/keys
umask 077

wg genkey | tee privatekey | wg pubkey > publickey
wg genkey | tee phone_privatekey | wg pubkey > phone_publickey
private_key=$(cat privatekey)
public_key=$(cat publickey)
phone_publickey=$(cat phone_publickey)
phone_privatekey=$(cat phone_privatekey)

default_interface=$(ip route | grep default | awk '{print $5}')
server_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)

touch /etc/wireguard/wg0.conf
cat <<EOT >> /etc/wireguard/wg0.conf
[Interface]
PrivateKey = $private_key
Address = 10.0.0.1/24
ListenPort = 51820
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o $default_interface -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o $default_interface -j MASQUERADE

[Peer]
PublicKey = $phone_publickey
AllowedIPs = 10.0.0.2/32
EOT

touch /etc/wireguard/wg0-phone.conf
cat <<EOT >> /etc/wireguard/wg0-phone.conf
[Interface]
PrivateKey = $phone_privatekey
Address = 10.0.0.2/32
DNS = 1.1.1.1

[Peer]
PublicKey = $public_key
Endpoint = $server_ip:51820
AllowedIPs = 0.0.0.0/0
EOT

sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sysctl -p

wg-quick up wg0
systemctl enable wg-quick@wg0.service
