# Set the base image
FROM dtanakax/debianjp:wheezy

# File Author / Maintainer
MAINTAINER Daisuke Tanaka, dtanakax@gmail.com
    
ENV DEBIAN_FRONTEND noninteractive
ENV INFLUXDB_VERSION 0.9.2

RUN apt-get update && \
    apt-get install -y curl openssl && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get clean all

RUN curl -s -o /tmp/influxdb_latest_amd64.deb https://s3.amazonaws.com/influxdb/influxdb_${INFLUXDB_VERSION}_amd64.deb && \
    dpkg -i /tmp/influxdb_latest_amd64.deb && \
    rm /tmp/influxdb_latest_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

# Adding the configuration file
COPY config.toml /config/config.toml
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Environment variable
ENV PRE_CREATE_DB **None**
ENV SSL_SUPPORT **False**
ENV SSL_CERT **None**

# Define mountable directories.
VOLUME ["/data"]

ENTRYPOINT ["./start.sh"]

# Set the port
# Admin server: 8083
# HTTP API:     8086
# HTTPS API:    8084
# Raft:         8090 for clustering
# Protobuf:     8099 for clustering
EXPOSE 8083 8086 8084 8090 8099

CMD ["/usr/bin/influxdb"]
