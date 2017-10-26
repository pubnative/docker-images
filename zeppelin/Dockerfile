# Image: pubnative/zeppelin

FROM dylanmei/zeppelin:0.7.2

RUN echo "deb http://repos.mesosphere.io/debian/ jessie main" > /etc/apt/sources.list.d/mesosphere.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF \
    && apt-get -y update \
    && apt-get -y install mesos \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN ./bin/install-interpreter.sh --name file,livy
