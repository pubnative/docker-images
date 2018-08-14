# Image: pubnative/zeppelin

FROM gettyimages/spark:2.3.1-hadoop-3.0

# Python packages
RUN set -ex \
 && buildDeps=' \
    libpython3-dev \
    build-essential \
    pkg-config \
    gfortran \
 ' \
 && apt-get update && apt-get install -y --no-install-recommends \
    $buildDeps \
    ca-certificates \
    wget \
    libblas-dev \
    libatlas-dev \
    liblapack-dev \
    libopenblas-dev \
    libpng-dev \
    libfreetype6-dev \
    libxft-dev \
    python3-tk \
    libxml2-dev \
    libxslt-dev \
    zlib1g-dev \
 && packages=' \
    numpy \
    pandasql \
    matplotlib \
    scipy \
 ' \
 && pip3 install $packages \
 && rm -rf /root/.cache/pip \
 && apt-get purge -y --auto-remove $buildDeps \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# R and its packages
RUN set -ex \
 && rDeps=' \
    r-base \
    r-base-dev \
    r-cran-evaluate \
 ' \
 && apt-get update && apt-get install -y --no-install-recommends $rDeps \
 && apt-get -y install r-base r-base-dev \
 && R -e "install.packages('knitr', repos='http://cran.us.r-project.org')" \
 && R -e "install.packages('ggplot2', repos='http://cran.us.r-project.org')" \
 && R -e "install.packages('googleVis', repos='http://cran.us.r-project.org')" \
 && R -e "install.packages('data.table', repos='http://cran.us.r-project.org')" \
 && apt-get -y install libcurl4-gnutls-dev libssl-dev \
 && R -e "install.packages('devtools', repos='http://cran.us.r-project.org')" \
 && R -e "install.packages('Rcpp', repos='http://cran.us.r-project.org')" \
 && Rscript -e "library('devtools'); library('Rcpp'); install_github('ramnathv/rCharts')" \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Zeppelin
ENV ZEPPELIN_PORT 8080
ENV ZEPPELIN_HOME /usr/zeppelin
ENV ZEPPELIN_CONF_DIR $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR $ZEPPELIN_HOME/notebook
ENV Z_VERSION 0.8.0
RUN echo '{ "allow_root": true }' > /root/.bowerrc
RUN apt-get update && apt-get install -y --no-install-recommends gnupg \
 && curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN set -ex \
 && additionalDeps=' \
    git \
    bzip2 \
    nodejs \
    npm \
    libfontconfig \
 ' \
 && apt-get update && apt-get install -y --no-install-recommends $additionalDeps \
 && wget -O /tmp/zeppelin-${Z_VERSION}-bin-all.tgz http://archive.apache.org/dist/zeppelin/zeppelin-${Z_VERSION}/zeppelin-${Z_VERSION}-bin-all.tgz \
 && tar -zxvf /tmp/zeppelin-${Z_VERSION}-bin-all.tgz \
 && rm -rf /tmp/zeppelin-${Z_VERSION}-bin-all.tgz \
 && mv ./zeppelin-${Z_VERSION}-bin-all ${ZEPPELIN_HOME}

RUN mkdir -p $ZEPPELIN_HOME/run

# Mesos
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt -q update && apt install -y libssl1.0.0
RUN echo 'deb http://repos.mesosphere.com/ubuntu xenial main' >> /etc/apt/sources.list.d/mesosphere.list
RUN apt-get install dirmngr && apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF \
 && apt-get -y update \
 && apt-get -y install mesos=1.3.0-2.0.3 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR $ZEPPELIN_HOME
CMD ["bin/zeppelin.sh"]
