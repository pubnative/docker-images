# Start from the official OpenJDK 11 image
FROM openjdk:11-jdk

LABEL maintainer="Eros Garcia Ponte <eros902002@googlemail.com>"

WORKDIR /usr/local/

# Install Development Tools
RUN apt-get update && apt-get install -y \
    software-properties-common \
    build-essential \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libncurses5-dev \
    libx11-dev \
    libxrender-dev \
    zlib1g-dev \
    curl \
    unzip \
    ruby \
    ruby-dev \
    && gem install bundler -v 2.3.10

# Set JAVA_HOME environment variable
ENV JAVA_HOME /usr/local/openjdk-11
ENV PATH $PATH:$JAVA_HOME/bin

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
ENV PATH $PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
ENV PATH $PATH:$ANDROID_SDK_ROOT/cmdline-tools/initversion/bin
ENV PATH $PATH:$ANDROID_SDK_ROOT/platform-tools

# Install Android tools
RUN yes | sdkmanager --update \
 && yes | sdkmanager "platforms;android-34" "build-tools;34.0.0" "extras;google;m2repository" "extras;android;m2repository"

# Clean up
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /usr/local/commandlinetools-linux-8092744_latest.zip

# List the contents of the work directory
RUN cd /usr/local/ && ls -la
