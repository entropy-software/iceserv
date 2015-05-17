FROM ubuntu
MAINTAINER Xavier Banegas <xavier@entropysoftware.co>

# workaround
# http://askubuntu.com/questions/135932/apt-get-update-failure-to-fetch-cant-connect-to-any-sources
RUN echo "nameserver 8.8.8.8" >> etc/resolv.conf
RUN /etc/init.d/resolvconf restart

RUN apt-get -y update
RUN apt-get -y install build-essential libxml2 libxslt-dev curl libvorbis-dev libogg-dev
# RUN apt-get -y install openssl 

RUN useradd -ms /bin/bash entropy
RUN adduser entropy sudo
WORKDIR home/entropy


RUN curl http://downloads.xiph.org/releases/icecast/icecast-2.4.1.tar.gz | tar xz
RUN cd icecast-2.4.1/ && ./configure && make && make install
RUN mkdir -p ../../usr/local/var/log/icecast/
RUN touch ../../usr/local/var/log/icecast/error.log ../../usr/local/var/log/icecast/access.log
RUN chown -R entropy:entropy ../../usr/local/var/log/icecast
RUN chown entropy:entropy ../../usr/local/etc/icecast.xml
ADD ./icecast.xml ../../usr/local/etc/icecast.xml

USER entropy

EXPOSE 8000