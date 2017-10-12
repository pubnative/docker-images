#!/bin/bash
#
# Docker script to configure and start an IPsec VPN server
#
# DO NOT RUN THIS SCRIPT ON YOUR PC OR MAC! THIS IS ONLY MEANT TO BE RUN
# IN A DOCKER CONTAINER!
#
# This file is part of IPsec VPN Docker image, available at:
# https://github.com/hwdsl2/docker-ipsec-vpn-server
#
# Copyright (C) 2016-2017 Lin Song <linsongui@gmail.com>
# Based on the work of Thomas Sarlandie (Copyright 2012)
#
# This work is licensed under the Creative Commons Attribution-ShareAlike 3.0
# Unported License: http://creativecommons.org/licenses/by-sa/3.0/
#
# Attribution required: please include my name in any derivative and let me
# know how you have improved it!
mkdir -p /opt
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export LC_ALL=C LANG=C

exit_err() { echo "Error: $@" >&2; exit 1; }

if [ ! -f "/.dockerenv" ]; then
  exit_err "This script ONLY runs in a Docker container."
fi

if ip link add dummy0 type dummy 2>&1 | grep -q "not permitted"; then
  exit_err $"
    Error: Can't manipulate with network interfaces!
    This docker image must be either run in privileged mode.
    Other way is to add --cap-add=NET_ADMIN to this container
    AND specify all sysctl paramenters via --sysctl parameter.
    "
fi
ip link delete dummy0 >/dev/null 2>&1

L2TP_NET=${VPN_L2TP_NET:-'192.168.42.0/24'}
L2TP_LOCAL=${VPN_L2TP_LOCAL:-'192.168.42.1'}
L2TP_POOL=${VPN_L2TP_POOL:-'192.168.42.10-192.168.42.250'}
XAUTH_NET=${VPN_XAUTH_NET:-'192.168.43.0/24'}
XAUTH_POOL=${VPN_XAUTH_POOL:-'192.168.43.10-192.168.43.250'}
DNS_SRV1=${VPN_DNS_SRV1:-'8.8.8.8'}
DNS_SRV2=${VPN_DNS_SRV2:-'8.8.4.4'}
VPN_NAME=${VPN_NAME:-'vpn.example.com'}


# Create IPsec (Libreswan) config
[[ -r /opt/ipsec-vpn/ipsec.conf ]] ||
cat > /opt/ipsec-vpn/ipsec.conf <<EOF
version 2.0

config setup
  virtual-private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12,%v4:!$L2TP_NET,%v4:!$XAUTH_NET
  protostack=mast
  nhelpers=0
  interfaces=%defaultroute
  uniqueids=no
  secretsfile=/opt/ipsec-vpn/ipsec.secrets

conn shared
  left=%defaultroute
  leftid=@${VPN_NAME}
  leftcert=/opt/ipsec-vpn/certs/${VPN_NAME}.pem
  right=%any
  rightca=%same
  rightrsasigkey=%cert
  encapsulation=yes
  authby=rsasig
  pfs=yes
  rekey=no
  keyingtries=5
  dpddelay=30
  dpdtimeout=120
  dpdaction=clear
  ike=aes256-sha2_512;modp2048,aes128-sha2_512;modp2048,aes256-sha1;modp1024,aes128-sha1;modp1024
  phase2alg=aes_ccm_c-256-null,aes256-sha2_512,aes-sha2,aes-sha1,3des-sha2,3des-sha1
  sha2-truncbug=yes

conn l2tp-psk
  auto=add
  leftprotoport=17/1701
  rightprotoport=17/%any
  type=transport
  phase2=esp
  also=shared

conn xauth-psk
  auto=add
  leftsubnet=0.0.0.0/0
  rightaddresspool=$XAUTH_POOL
  modecfgdns1=$DNS_SRV1
  modecfgdns2=$DNS_SRV2
  leftxauthserver=yes
  rightxauthclient=yes
  leftmodecfgserver=yes
  rightmodecfgclient=yes
  modecfgpull=yes
  ike-frag=yes
  ikev2=insist
  cisco-unity=yes
  also=shared
EOF

# Specify IPsec PSK
[[ -r /opt/ipsec-vpn/ipsec.secrets ]] ||
cat > /opt/ipsec-vpn/ipsec.secrets <<EOF
%any  %any  : PSK "$VPN_IPSEC_PSK"
EOF

# Create xl2tpd config
[[ -r /opt/ipsec-vpn/xl2tpd.conf ]] ||
cat > /opt/ipsec-vpn/xl2tpd.conf <<EOF
[global]
port = 1701

[lns default]
ip range = $L2TP_POOL
local ip = $L2TP_LOCAL
require chap = yes
refuse pap = yes
require authentication = yes
name = l2tpd
pppoptfile = /opt/ipsec-vpn/options.xl2tpd
length bit = yes
EOF

# Set xl2tpd options
[[ -r /opt/ipsec-vpn/options.xl2tpd ]] ||
cat > /opt/ipsec-vpn/options.xl2tpd <<EOF
+mschap-v2
ipcp-accept-local
ipcp-accept-remote
ms-dns $DNS_SRV1
ms-dns $DNS_SRV2
noccp
auth
mtu 1280
mru 1280
proxyarp
lcp-echo-failure 4
lcp-echo-interval 30
connect-delay 5000
EOF

# Create VPN credentials
[[ -r /opt/ipsec-vpn/chap-secters ]] ||
cat > /opt/ipsec-vpn/chap-secrets <<EOF
# Secrets for authentication using CHAP
# client  server  secret  IP addresses
"$VPN_USER" l2tpd "$VPN_PASSWORD" *
EOF

[[ -r /opt/ipsec-vpn/ipsec.passwd ]] ||
cat > /opt/ipsec-vpn/ipsec.passwd <<EOF
$VPN_USER:$VPN_PASSWORD_ENC:xauth-psk
EOF

# Update sysctl settings
cat > /etc/sysctl.d/99-ipsec.conf <<EOF
kernel.msgmnb=65536
kernel.msgmax=65536
kernel.shmmax=68719476736
kernel.shmall=4294967296
net.ipv4.ip_forward=1
net.ipv4.conf.all.accept_source_route=0
net.ipv4.conf.default.accept_source_route=0
net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.default.accept_redirects=0
net.ipv4.conf.all.send_redirects=0
net.ipv4.conf.default.send_redirects=0
net.ipv4.conf.lo.send_redirects=0
net.ipv4.conf.eth0.send_redirects=0
net.ipv4.conf.all.rp_filter=0
net.ipv4.conf.default.rp_filter=0
net.ipv4.conf.lo.rp_filter=0
net.ipv4.conf.eth0.rp_filter=0
net.ipv4.icmp_echo_ignore_broadcasts=1
net.ipv4.icmp_ignore_bogus_error_responses=1
EOF

sysctl -p /etc/sysctl.d/99-ipsec.conf

# Create IPTables rules if no defaults
[[ -r /opt/ipsec-vpn/iptables ]] ||
cat > /opt/ipsec-vpn/iptables <<EOF
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -p udp --dport 1701 -m policy --dir in --pol none -j DROP
-A INPUT -m conntrack --ctstate INVALID -j DROP
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p udp -m multiport --dports 500,4500 -j ACCEPT
-A INPUT -p udp --dport 1701 -m policy --dir in --pol ipsec -j ACCEPT
-A INPUT -p udp --dport 1701 -j DROP
-A FORWARD -m conntrack --ctstate INVALID -j DROP
-A FORWARD -i eth+ -o ppp+ -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i ppp+ -o eth+ -j ACCEPT
-A FORWARD -i ppp+ -o ppp+ -s "$L2TP_NET" -d "$L2TP_NET" -j ACCEPT
-A FORWARD -i eth+ -d "$XAUTH_NET" -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -s "$XAUTH_NET" -o eth+ -j ACCEPT
-A FORWARD -j DROP
*nat
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A POSTROUTING -s "$XAUTH_NET" -o eth+ -m policy --dir out --pol none -j MASQUERADE
-A POSTROUTING -s "$L2TP_NET" -o eth+ -j MASQUERADE
EOF

iptables-restore /opt/ipsec-vpn/iptables

# Update file attributes
chmod 600 /etc/ipsec.secrets /etc/ppp/chap-secrets /etc/ipsec.d/passwd

# Load IPsec NETKEY kernel module
modprobe af_key af_alg

# Start services
mkdir -p /var/run/pluto /var/run/xl2tpd
rm -f /var/run/pluto/pluto.pid /var/run/xl2tpd.pid

ipsec start --config /etc/ipsec.conf
exec /usr/sbin/xl2tpd -D -c /etc/xl2tpd/xl2tpd.conf
