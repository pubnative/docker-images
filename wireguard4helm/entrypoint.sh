#!/bin/bash
set -e

if [ "$INTERFACE_NAME" == "" ]; then
  echo "$(date -R) INTERFACE_NAME env not set"
  exit 1
fi

if [ "$LOCAL_IP" == "" ]; then
  echo "$(date -R) LOCAL_IP env not set"
  exit 1
fi

if [ "$LOCAL_NETMASK" == "" ]; then
  echo "$(date -R) LOCAL_NETMASK env not set"
  exit 1
fi

if [ -f "$PRIVATE_KEY" ]; then
  PRIVATE_KEY_FILE=$PRIVATE_KEY
elif [ "44" == "$( echo -n $PRIVATE_KEY | wc -c )" ]; then
  touch /root/wg-private-key
  chmod 600 /root/wg-private-key
  echo "$PRIVATE_KEY" > /root/wg-private-key
  PRIVATE_KEY_FILE=/root/wg-private-key
elif [ "" == "$PRIVATE_KEY" ]; then
  echo "$(date -R) PRIVATE_KEY not passed, generating one"
  touch /root/wg-private-key
  chmod 600 /root/wg-private-key
  /usr/bin/wg genkey > /root/wg-private-key
  PRIVATE_KEY_FILE=/root/wg-private-key
else
  echo "$(date -R) PRIVATE_KEY env not 44 chars long or an accessible file"
  exit 1
fi

if ! grep '^wireguard ' /proc/modules 2>&1 > /dev/null; then
  chroot /hostrootpath modprobe wireguard || \
  echo "$(date -R) ERROR Wireguard module not loaded and refused to load" ;\
  exit 99
fi

if [ "$REPORT_INTERVAL" == "" ]; then
  REPORT_INTERVAL=300
fi

if [ "$LISTEN_PORT" != "" ]; then
  LISTEN_ARGS="listen-port $LISTEN_PORT"
fi

if /bin/ip addr show $INTERFACE_NAME 2>&1 > /dev/null; then
  echo "$(date -R) $INTERFACE_NAME already exists, attempting cleanup"
  /bin/ip link del $INTERFACE_NAME
fi

echo "$(date -R) Starting the tunnel"
/bin/ip link add $INTERFACE_NAME type wireguard
/bin/ip addr add $LOCAL_IP/$LOCAL_NETMASK dev $INTERFACE_NAME
/usr/bin/wg set $INTERFACE_NAME private-key $PRIVATE_KEY_FILE $LISTEN_ARGS
/bin/ip link set $INTERFACE_NAME up

if [ "yes" == "$ENABLE_FORWARDING" ]; then
  #accept from the tunnel
  iptables -A FORWARD -i wg+ -s $LOCAL_IP/$LOCAL_NETMASK -j ACCEPT
  #accept to the tunnel but only from this machine
  iptables -A FORWARD -i wg+ -s $LOCAL_IP -d $LOCAL_IP/$LOCAL_NETMASK -j ACCEPT
fi

if [ "" != "$PEERS_FILE" ] && [ -f $PEERS_FILE ]; then
  while read currentpeer; do
    PEER_PUB_KEY=$(echo $currentpeer | awk '{print $1}')
    PEER_HOST=$(echo $currentpeer | awk '{print $2}')
    PEER_PORT=$(echo $currentpeer | awk '{print $3}')
    PEER_ALLOWED_IPS=$(echo $currentpeer | awk '{print $4}')
    if echo "$PEER_ALLOWED_IPS" | grep ',$' > /dev/null; then
      ACTUAL_PEER_ALLOWED_IPS=$(echo $PEER_ALLOWED_IPS | sed s/',$'//)
    else
      ACTUAL_PEER_ALLOWED_IPS=$PEER_ALLOWED_IPS
    fi
    echo "$(date -R) Adding peer $PEER_HOST"
    /usr/bin/wg set $INTERFACE_NAME peer $PEER_PUB_KEY allowed-ips $ACTUAL_PEER_ALLOWED_IPS endpoint $PEER_HOST:$PEER_PORT
  done <$PEERS_FILE
fi

if [ "" != "$ROUTES_FILE" ] && [ -f $ROUTES_FILE ]; then
  while read currentroute; do
    ROUTE_CIDR=$(echo $currentroute | awk '{print $1}')
    ROUTE_REMOTE=$(echo $currentroute | awk '{print $2}')
    # remove any existing route for this cidr
    ip route del $ROUTE_CIDR || true
    echo "$(date -R) Adding route for $ROUTE_CIDR via gateway $ROUTE_REMOTE"
    ip route add $ROUTE_CIDR via $ROUTE_REMOTE
    if [ "yes" == "$ENABLE_FORWARDING" ]; then
      iptables -A FORWARD -i wg+ -d $ROUTE_CIDR -j ACCEPT
      iptables -A FORWARD -i wg+ -s $ROUTE_CIDR -j ACCEPT
    fi
  done <$ROUTES_FILE
fi

while true; do
  echo $(date -R) output of wg status :
  /usr/bin/wg show
  sleep $REPORT_INTERVAL
done
#EOF
