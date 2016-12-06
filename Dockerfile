FROM ubuntu:xenial

MAINTAINER pzucchi@gmail.com

ENV PUPPET_VERSION latest
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y wget
RUN wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
RUN dpkg -i puppetlabs-release-pc1-xenial.deb
RUN apt update

RUN apt-get install -y puppetserver



ADD puppet.conf /etc/puppetlabs/puppet.conf

VOLUME ["/opt/puppet"]

RUN cp -rf /etc/puppetlabs/* /opt/puppetlabs/

VOLUME ["/opt/varpuppetlabs/lib/puppet"]

#RUN cp -rf /var/lib/puppet/* /opt/varpuppet/lib/puppet/

EXPOSE 8140

ENTRYPOINT [ "/usr/bin/puppet", "master", "--no-daemonize", "--verbose" 
