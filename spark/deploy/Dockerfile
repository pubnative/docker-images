FROM centos:7

RUN rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm \
  && yum update -y \
  && yum install -y mesos-1.3.0 java-1.8.0-openjdk java-1.8.0-openjdk-devel \
  && yum clean all
