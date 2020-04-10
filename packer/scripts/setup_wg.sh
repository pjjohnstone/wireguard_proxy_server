mkdir /etc/wireguard/keys
cd /etc/wireguard/keys
umask 077

wg genkey | tee privatekey | wg pubkey > publickey
private_key=$(cat privatekey)
public_key=$(cat publickey)
default_interface=$(ip route | grep default | awk '{print $5}')

touch /etc/wireguard/wg0.conf
cat <<EOT >> /etc/wireguard/wg0.conf
[Interface]
PrivateKey = $private_key
Address = 10.0.0.1/24
ListenPort = 51820
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o $default_interface -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o $default_interface -j MASQUERADE
EOT
