## InfluxDB Dockerfile


This repository contains **Dockerfile** of [InfluxDB](http://influxdb.com/) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/puckel/docker-influxdb/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [puckel/docker-base](https://registry.hub.docker.com/u/puckel/docker-base/)


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/puckel/docker-influxdb/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull puckel/docker-influxdb`

Alternatively, you can build an image from [Dockerfile](https://github.com/puckel/docker-influxdb)

### Usage

```bash
    docker run -d \
        --name influxdb \
        -p 8083:8083 \
        -p 8086:8086 \
        -p 8090:8090 \
        -p 25826:25826/udp \
        puckel/docker-influxdb
```

After few seconds, open `http://localhost:8083/` (credentials : root/root) to see the result.

Note : A `collectd` database is automatically created.
