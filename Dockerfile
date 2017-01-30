# Use phusion/baseimage as base image.
FROM stratolinux/baseimage-docker:0.9.19
MAINTAINER Eric Young <eric@stratolinux.com>
ENV SICKDIR /opt/sickrage

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# To get rid of error messages like "debconf: unable to initialize frontend: Dialog":
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list
RUN apt-get -qy update && apt-get -qy upgrade

# shared volumes
VOLUME /config
VOLUME /downloads
# ports
EXPOSE 8080 9090

# ...put build instructions here...
RUN apt-get install -qy par2 python-yenc unzip unrar
RUN apt-get install -qy python-software-properties software-properties-common

RUN add-apt-repository -y  ppa:jcfp/ppa
RUN apt-get install -qy --force-yes sabnzbdplus
RUN apt-get install -qy --force-yes sabnzbdplus-theme-classic sabnzbdplus-theme-mobile sabnzbdplus-theme-plush

COPY etc/ /etc/

RUN chmod +x /etc/my_init.d/*
RUN find /etc/service -name run -exec chmod +x {} \;

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
