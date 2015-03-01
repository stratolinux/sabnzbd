FROM ubuntu:14.04
MAINTAINER Eric Young <eric@stratolinux.com>

# To get rid of error messages like "debconf: unable to initialize frontend: Dialog":
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list
RUN apt-get -q update

RUN apt-get install -qy python-software-properties software-properties-common

RUN add-apt-repository -y  ppa:jcfp/ppa

RUN apt-get -q update

RUN apt-get install -qy --force-yes sabnzbdplus
RUN apt-get install -qy --force-yes sabnzbdplus-theme-classic sabnzbdplus-theme-mobile sabnzbdplus-theme-plush
RUN apt-get install -qy --force-yes par2 python-yenc unzip unrar

RUN apt-get -qy upgrade

# apt clean
RUN apt-get clean &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf /tmp/* &&\
  rm -rf /var/tmp/*

VOLUME /config
VOLUME /data

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 8080 9090

CMD ["/start.sh"]
