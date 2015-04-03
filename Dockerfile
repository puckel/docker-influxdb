# VERSION 1.0
# AUTHOR: Matthieu "Puckel_" Roisil
# DESCRIPTION: Basic InfluxDB container
# BUILD: docker build --rm -t puckel/docker-influxdb
# SOURCE: https://github.com/puckel/docker-influxdb
# Based on https://github.com/tutumcloud/tutum-docker-influxdb

FROM puckel/docker-base
MAINTAINER Puckel_

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
# Work around initramfs-tools running on kernel 'upgrade': <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189>
ENV INITRD No
ENV INFLUXDB_VERSION 0.9.0-rc18
ENV PRE_CREATE_DB collectd

RUN apt-get update -yqq \
    && apt-get install -yqq ca-certificates \
    && curl -sL -O http://get.influxdb.org/influxdb_${INFLUXDB_VERSION}_amd64.deb \
    && dpkg -i influxdb_${INFLUXDB_VERSION}_amd64.deb \
    && rm influxdb_${INFLUXDB_VERSION}_amd64.deb
ADD config/config.toml /opt/influxdb/shared/config.toml
ADD https://raw.githubusercontent.com/collectd/collectd/master/src/types.db /usr/share/collectd/types.db
ADD scripts/run.sh /run.sh
RUN chmod +x /run.sh


EXPOSE 8083 8086 25827/udp

VOLUME ["/data"]

ENTRYPOINT ["/run.sh"]
