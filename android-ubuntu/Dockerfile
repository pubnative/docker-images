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
 && gem install bundler -v 2.3.10

# Install Java 1.11 in CentOS/RHEL 7.X
RUN cd /usr/local/ \
 && curl -s -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/11.0.14%2B8/7e5bbbfffe8b45e59d52a96aacab2f04/jdk-11.0.14_linux-x64_bin.rpm > jdk-11.0.14_linux-x64_bin.rpm \
 && yum -y localinstall jdk-11.0.14_linux-x64_bin.rpm

# Java environment variables
ENV JAVA_VERSION 1.11
ENV JAVA_HOME /usr/java/jdk-11.0.14
ENV JRE_HOME /usr/java/jdk-11.0.14/jre
ENV PATH $PATH:/usr/java/jdk-11.0.14/bin:/usr/java/jdk-11.0.14/jre/bin

# Install Android SDK
RUN mkdir -p /usr/local/android-sdk \
 && cd /usr/local/android-sdk \
 && curl -L -O https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip \
 && unzip commandlinetools-linux-8092744_latest.zip

RUN mv /usr/local/android-sdk/cmdline-tools /usr/local/android-sdk/initversion \
 && mkdir /usr/local/android-sdk/cmdline-tools \
 && mv /usr/local/android-sdk/initversion /usr/local/android-sdk/cmdline-tools/initversion

# Environment variables
ENV ANDROID_HOME /usr/local/android-sdk
ENV ANDROID_SDK_ROOT /usr/local/android-sdk
# adding "latest" first to PATH so it will have higher priority
# after "update" we will have latest binaries under "latest" folder
ENV PATH $PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
ENV PATH $PATH:$ANDROID_SDK_ROOT/cmdline-tools/initversion/bin
ENV PATH $PATH:$ANDROID_SDK_ROOT/platform-tools
ENV PATH $PATH:$ANT_HOME/bin

# Install Android tools
RUN sdkmanager --update <<< 'y'
RUN yes | sdkmanager "platforms;android-32" "build-tools;32.0.0" "extras;google;m2repository" "extras;android;m2repository"
#RUN echo yes | /usr/local/android-sdk-linux/tools/android update sdk --filter android-32 --no-ui --force -a
#RUN echo yes | /usr/local/android-sdk-linux/tools/android update sdk --filter platform-tools --no-ui --force -a
#RUN echo yes | /usr/local/android-sdk-linux/tools/android update sdk --filter tools --no-ui --force -a
#RUN echo yes | /usr/local/android-sdk-linux/tools/android update sdk --filter extra --no-ui --force -a

RUN cd /usr/local/ && ls -la

# Clean up
RUN yum clean all
RUN rm -rf /usr/local/commandlinetools-linux-8092744_latest.zip /usr/local/jdk-11.0.14_linux-x64_bin.rpm /var/cache/yum
