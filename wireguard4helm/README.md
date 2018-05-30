# wireguard4helm

Docker image for the helm chart that uses wireguard tools to orchestrate a wireguard vpn based on environment variables (and a peers file if you want outbound connections)

example env vars :

INTERFACE_NAME=wg0
LOCAL_IP=100.64.0.1
LOCAL_NETMASK=30
PRIVATE_KEY=/root/wg-private-key
PEERS_FILE=peers.txt
LISTEN_PORT=54321
REPORT_INTERVAL=300

If you don't specify a PRIVATE_KEY, one will be created.

If you don't specify a LISTEN_PORT, wireguard will choose one at random, which is tricky to forward.

REPORT_INTERVAL has a default of 300 seconds, this is the delay between calls to `wg show` which the script runs over and again.

The format of peers.txt is 

{{ public_key }} {{ peerhostip }} {{ peerport }} {{ allowed_cidrs,comma_separated }}

e.g.
sLwqs50QHbsk3qglcyegq3QjNwZFSRdAgIP78B3Q9Wg= 1.2.3.4 43072 10.96.0.0/12,10.32.0.1/12
