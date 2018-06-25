# Usage

```shell
$ docker build -t pubnative/vpn:3.22 .
$ docker push pubnative/vpn:3.22
```

### Environment variables

`DESTINATION_NET` - traffic only to this network will be allowed while routing.
Example: `10.0.0.0/16`

`ALLOWED_SERVICES` - per-service filter tuning. Allows access to this services from vpn clients.
Format is: `DESTNET,[proto:]port[ …]`
Example: `10.20.30.0/24,80 192.168.100.1,udp:53 172.16.0.0/22,vrrp:0 10.20.30.0/23,tcp:6379-6400 10.20.30.0/23,icmp:0 10.20.30.0/23,icmp:3 10.20.30.0/23,icmp:8`

#### See also
`man ipset(8) #hash:net,port`
