# IPsec VPN Server on Docker

Docker image to run an IPsec VPN server, with both `IPsec/L2TP` and `Cisco IPsec`.

Based on Debian 9 (Stretch) with [Libreswan](https://libreswan.org) (IPsec VPN software) and [xl2tpd](https://github.com/xelerance/xl2tpd) (L2TP daemon).

```
docker run \
    --restart=always \
    -p 500:500/udp \
    -p 4500:4500/udp \
    -v /lib/modules:/lib/modules:ro \
    -v ipsec-data:/opt/ipsec-vpn \
    -d --privileged \
    pubnative/ipsec-vpn-server
```
