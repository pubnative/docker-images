# Image pubnative/android
FROM drecom/centos-ruby

LABEL maintainer="Eros Garcia Ponte <eros902002@googlemail.com>"

WORKDIR /usr/local/

# Install Development Tools
RUN yum -y update \
 && yum -y groupinstall "Development Tools" \
 && yum install -y glibc.i686 \
                   libstdc++.i686 \
                   glibc-devel.i686 \
                   zlib-devel.i686 \
                   ncurses-devel.i686 \
                   libX11-devel.i686 \
                   libXrender.i686 \
 && gem install bundler -v 2.4.22

# Install Java 1.8 in CentOS/RHEL 7.X
RUN cd /usr/local/ \
 && curl -s -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm > jdk-17_linux-x64_bin.rpm \
 && yum -y localinstall jdk-17_linux-x64_bin.rpm

# Java environment variables
ENV JAVA_VERSION 17
ENV JAVA_HOME /usr/java/jdk-17
ENV JRE_HOME /usr/java/jdk-17/jre
ENV PATH $PATH:/usr/java/jdk-17/bin:/usr/java/jdk-17/jre/bin

# Install Android SDK
RUN mkdir -p /usr/local/android-sdk \
 && cd /usr/local/android-sdk \
 && curl -L -O https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip \
 && unzip commandlinetools-linux-7302050_latest.zip

# Install Android tools
RUN /usr/local/android-sdk/cmdline-tools/bin/sdkmanager --update --sdk_root=/usr/local/android-sdk \
 && yes | /usr/local/android-sdk/cmdline-tools/bin/sdkmanager --sdk_root=/usr/local/android-sdk "platforms;android-34" "build-tools;34.0.0" "extras;google;m2repository" "extras;android;m2repository"

# Environment variables
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $PATH:$ANDROID_HOME/cmdline-tools/latest/bin
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANT_HOME/bin

# Clean up
RUN yum clean all
RUN rm -rf /usr/local/commandlinetools-linux-7302050_latest.zip /usr/local/jdk-17_linux-x64_bin.rpm /var/cache/yum
