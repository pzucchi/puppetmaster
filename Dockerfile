FROM centos:centos7

MAINTAINER pzucchi@gmail.com

ENV PUPPET_VERSION latest

RUN rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs && rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
RUN rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
RUN yum install -y yum-utils && yum-config-manager --enable centosplus >& /dev/null
RUN yum install puppetserver
sudo yum install puppet-agent
RUN yum clean all
##ADD puppet.conf /etc/puppet/puppet.conf

VOLUME ["/opt/puppet"]

RUN cp -rf /etc/puppet/* /opt/puppet/

VOLUME ["/opt/varpuppet/lib/puppet"]

RUN cp -rf /var/lib/puppet/* /opt/varpuppet/lib/puppet/

EXPOSE 8140

ENTRYPOINT [ "/usr/bin/puppet", "master", "--no-daemonize", "--verbose" 
