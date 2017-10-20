# Image: pubnative/vpn

FROM hwdsl2/ipsec-vpn-server
MAINTAINER Pubnative Tech <team@pubnative.net>

COPY ./run.sh /opt/src/run.sh
RUN chmod 755 /opt/src/run.sh

CMD ["bash", "/opt/src/run.sh"]
