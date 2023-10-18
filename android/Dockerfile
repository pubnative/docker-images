# Image pubnative/android

FROM drecom/centos-ruby

LABEL maintainer="Eros Garcia Ponte <eros902002@googlemail.com>"

WORKDIR /usr/local/

# Install Development Tools
RUN yum -y update \
 && yum -y groupinstall "Development Tools" \
 : Install ruby for fastlane and 32bits libs \
 && yum install -y glibc.i686 \
                   libstdc++.i686 \
                   glibc-devel.i686 \
                   zlib-devel.i686 \
                   ncurses-devel.i686 \
                   libX11-devel.i686 \
                   libXrender.i686 \
 && gem install bundler -v 1.7.3 \
 && gem install fastlane

# Install Java 17 in CentOS/RHEL 7.X
RUN cd /usr/local/ \
 && curl -s -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/17/archive/jdk-17.0.9_linux-x64_bin.rpm > jdk-17.0.9_linux-x64_bin.rpm \
 && yum -y localinstall jdk-17.0.9_linux-x64_bin.rpm

# Java environment variables
ENV JAVA_VERSION 17
# ENV JAVA_HOME /usr/java/jdk1.8.0_131
ENV JAVA_HOME /usr/lib/jvm/jdk-17-oracle-aarch64
# ENV JRE_HOME /usr/java/jdk1.8.0_131/jre
# ENV PATH $PATH:/usr/java/jdk1.8.0_131/bin:/usr/java/jdk1.8.0_131/jre/bin
ENV PATH $PATH:/usr/lib/jvm/jdk-17-oracle-aarch64/bin

# Install Android SDK
RUN mkdir -p /usr/local/android-sdk \
 && cd /usr/local/android-sdk \
 && curl -L -O https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip \
 && unzip commandlinetools-linux-10406996_latest.zip

# # Install Android tools
# RUN /usr/local/android-sdk/tools/bin/sdkmanager --update <<< 'y'
# RUN yes | /usr/local/android-sdk/tools/bin/sdkmanager "platforms;android-28" "build-tools;28.0.3" "extras;google;m2repository" "extras;android;m2repository"
# #RUN echo yes | /usr/local/android-sdk-linux/tools/android update sdk --filter android-28 --no-ui --force -a
# #RUN echo yes | /usr/local/android-sdk-linux/tools/android update sdk --filter platform-tools --no-ui --force -a
# #RUN echo yes | /usr/local/android-sdk-linux/tools/android update sdk --filter tools --no-ui --force -a
# #RUN echo yes | /usr/local/android-sdk-linux/tools/android update sdk --filter extra --no-ui --force -a

# Install Android tools
RUN /usr/local/android-sdk/cmdline-tools/bin/sdkmanager --update <<< 'y'
RUN yes | /usr/local/android-sdk/cmdline-tools/bin/sdkmanager "platforms;android-34" "build-tools;34.0.0" "extras;google;m2repository" "extras;android;m2repository"

RUN cd /usr/local/ && ls -la

# Environment variables
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANT_HOME/bin

# Clean up
RUN yum clean all
RUN rm -rf /usr/local/commandlinetools-linux-10406996_latest.zip /usr/local/jdk-17.0.9_linux-x64_bin.rpm /var/cache/yum